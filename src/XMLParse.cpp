// -*-c++-*-
// Time-stamp: <2003-10-07 14:35:50 pmistry>
//-----------------------------------------------------------------------------
// File : XMLParse.cpp
// Desc : Class implementation for scenario file parsing
//-----------------------------------------------------------------------------
// mm-dd-yyyy  History                                                      tri
// 09-23-2003  Cre                                                          pie
//-----------------------------------------------------------------------------
#include "cramp.h"
#include "TestCaseInfo.h"
#include "XMLParse.h"

#include <list>
#include <string>

// #include <string.h>
#include <stdlib.h>
#include <fstream.h>

#include <xercesc/util/PlatformUtils.hpp>
#include <xercesc/parsers/AbstractDOMParser.hpp>
#include <xercesc/dom/DOMImplementation.hpp>
#include <xercesc/dom/DOMImplementationLS.hpp>
#include <xercesc/dom/DOMImplementationRegistry.hpp>
#include <xercesc/dom/DOMBuilder.hpp>
#include <xercesc/dom/DOMException.hpp>
#include <xercesc/dom/DOMDocument.hpp>
#include <xercesc/dom/DOMNodeList.hpp>
#include <xercesc/dom/DOMError.hpp>
#include <xercesc/dom/DOMLocator.hpp>

#include <xercesc/util/PlatformUtils.hpp>
#include <xercesc/util/XMLString.hpp>
#include <xercesc/dom/DOM.hpp>
#include <iostream.h>

#define SCENARIO 1
#define GROUP 2
#define TESTCASE 3

typedef enum{
  ID=0,
  NAME,
  RELEASE,
  MAXRUNTIME,
  PROFILING,
  BLOCK,
  REINITIALIZEDATA,
  STOPONFIRSTFAILURE,
  EXECPATH,
  NUMRUNS
}AttributeEnum;

// Internal map between value and attribute
typedef struct{
  int index;
  char *attrvalue;
}MyElement;

// Map between major type and attributes
typedef struct{
  int type;
  const char *attr;
  AttributeEnum attrenum;
}ElemAttr;

ElemAttr g_ElemAttrMap[]={
  SCENARIO, "ID"                  ,   ID                  ,//0
  SCENARIO, "NAME"                ,   NAME                ,//1
  SCENARIO, "RELEASE"             ,   RELEASE             ,//2
  SCENARIO, "MAXRUNTIME"          ,   MAXRUNTIME          ,//6
  SCENARIO, "PROFILING"           ,   PROFILING           ,//7
  GROUP   , "ID"                  ,   ID                  ,//8
  GROUP   , "NAME"                ,   NAME                ,//9
  GROUP   , "BLOCK"               ,   BLOCK               ,//10
  GROUP   , "REINITIALIZEDATA"    ,   REINITIALIZEDATA    ,//11
  GROUP   , "STOPONFIRSTFAILURE"  ,   STOPONFIRSTFAILURE  ,//12
  GROUP   , "PROFILING"           ,   PROFILING           ,//13
  TESTCASE, "ID"                  ,   ID                  ,//14
  TESTCASE, "EXECPATH"            ,   EXECPATH            ,//15
  TESTCASE, "NUMRUNS"             ,   NUMRUNS             ,//16
  TESTCASE, "NAME"                ,   NAME                ,//17
  TESTCASE, "PROFILING"           ,   PROFILING           ,//18
  TESTCASE, "BLOCK"               ,   BLOCK               ,//19
  0,0};

//-----------------------------------------------------------------------------
// XMLParse
//-----------------------------------------------------------------------------
XMLParse::XMLParse(const char *iXMLFileName){
  _pXMLFileName=iXMLFileName;
  _pRoot=0;
  _pCurrentParent=0;
}

//-----------------------------------------------------------------------------
// ~XMLParse
//-----------------------------------------------------------------------------
XMLParse::~XMLParse(){
  _pXMLFileName="";
  _pRoot=0;
}

//-----------------------------------------------------------------------------
// ParseXMLFile
//-----------------------------------------------------------------------------
bool
XMLParse::ParseXMLFile(void){
  bool ret=false;
  // Initialize the XML4C2 system.
  try{
    XMLPlatformUtils::Initialize();
  }

  catch(const XMLException& toCatch){
    char *pMsg=XMLString::transcode(toCatch.getMessage());
    cout << "Error during Xerces-c Initialization.\n"
         << "  Exception message:"
         << pMsg;
    XMLString::release(&pMsg);
    return(ret);
  }

  do{
    // Watch for special case help request
    if(_pXMLFileName==""){
      cout << "\nUsage:\n"
        "    CreateDOMDocument\n\n"
        "This program creates a new DOM document from scratch in memory.\n"
        "It then prints the count of elements in the tree.\n"
           <<  endl;
      break;
    }

    // Instantiate the DOM parser.
    static const XMLCh gLS[]={chLatin_L,chLatin_S,chNull};
    //static const XMLCh gLS[3];
    DOMImplementation *impl=0;
    impl=DOMImplementationRegistry::getDOMImplementation(gLS);
    if(!impl)
      break;

    DOMBuilder *parser=0;
    parser=((DOMImplementationLS *)impl)->createDOMBuilder(
      DOMImplementationLS::MODE_SYNCHRONOUS,0);
    DEBUGCHK(parser);

    bool doNamespaces=false;
    bool doSchema=false;
    bool schemaFullChecking=false;

    parser->setFeature(XMLUni::fgDOMNamespaces,doNamespaces);
    parser->setFeature(XMLUni::fgXercesSchema,doSchema);
    parser->setFeature(XMLUni::fgXercesSchemaFullChecking,schemaFullChecking);

    // the input is a list file
    ifstream fin;
    int argInd=0;
    fin.open(_pXMLFileName);
    DEBUGCHK(!fin.fail());

    const char *xmlFile=0;
    xmlFile=_pXMLFileName;

    // Pass xml file to parser
    DOMDocument *doc=0;
    doc=parser->parseURI(xmlFile);
    DEBUGCHK(doc);

    // Find root element
    DOMElement *rootElem=0;
    rootElem=doc->getDocumentElement();
    DEBUGCHK(rootElem);

    char *rootelemname=XMLString::transcode(rootElem->getTagName());
    DEBUGCHK(!stricmp(rootelemname,"SCENARIO"));
    if(rootelemname)
      XMLString::release(&rootelemname);

    // SCENARIO
    DOMNode *rootnode=rootElem;
    ScanXMLFile(rootnode,SCENARIO);
    ret=true;
  }while(0);

  // Terminate the XML parsing
  XMLPlatformUtils::Terminate();

  return(ret);
}

//-----------------------------------------------------------------------------
// ScanXMLFile
//-----------------------------------------------------------------------------
void
XMLParse::ScanXMLFile(DOMNode *parentchnode,int type){
  // SCENARIO
  if(SCENARIO==type)
    ScanForAttributes(parentchnode,SCENARIO);

  // Get all nodes
  DOMNodeList *childlist=parentchnode->getChildNodes();
  if(!childlist)
    return;

  int childsize=childlist->getLength();
  if(!childsize)
    return;

  char  *textName="#text";
  char  *groupName="GROUP";
  char  *testcaseName="TESTCASE";
  DOMNode *nextnode=0;

  for(int ss=0;ss<childsize;ss++){
    DOMNode *parentchnode=0;
    parentchnode=childlist->item(ss);
    if(!parentchnode)
      continue;

    char *parentchname=XMLString::transcode(parentchnode->getNodeName());

    // #text
    if(!stricmp(parentchname,textName))
      continue;

    // GROUP
    if(!stricmp(parentchname,groupName)){
      ScanForAttributes(parentchnode,GROUP);
      ScanXMLFile(parentchnode,GROUP);
    }else if(!stricmp(parentchname,testcaseName)){
      // TESTCASE
      ScanForAttributes(parentchnode,TESTCASE);
    }
    XMLString::release(&parentchname);
  }
  return;
}

//-----------------------------------------------------------------------------
// ScanForAttributes
//-----------------------------------------------------------------------------
void
XMLParse::ScanForAttributes(DOMNode *rootnode,
                            int type){
  if(!rootnode)
    return;

  int SecSize=0;
  DOMNamedNodeMap *pSceAttlist=0;

  pSceAttlist=rootnode->getAttributes();
  if(!pSceAttlist)
    return;

  SecSize=pSceAttlist->getLength();
  if(!SecSize)
    return;

  std::list<MyElement> myelement;
  TestCaseInfo *pChild=0;
  bool created=false;
  char *pIDval=0;

  for(int ss=0;ss<SecSize;ss++){
    MyElement object;
    object.index=-1;

    DOMNode *newAtt=pSceAttlist->item(ss);
    char *attriName=XMLString::transcode(newAtt->getNodeName());
    char *attriValue=XMLString::transcode(newAtt->getNodeValue());
    bool valid=false;

    for(int zz=0;!valid&&g_ElemAttrMap[zz].attr;zz++){
      if(type==g_ElemAttrMap[zz].type)
        if(!stricmp(g_ElemAttrMap[zz].attr,
                    attriName)){
          object.index=zz;
          object.attrvalue=attriValue;
          myelement.push_back(object);
          valid=true;
          if(!stricmp(attriName,"ID")){
            pIDval=new char[strlen(attriValue)+1];
            strcpy(pIDval,attriValue);
          }
        }
      if(!valid)
        continue;
    }
    XMLString::release(&attriName);
  }

  // ID has to be used at creation time! Do it first
  switch(type){
    case SCENARIO:
      // Create scenario group
      pChild=TestCaseInfo::CreateScenario(pIDval);
      _pRoot=pChild;
      _pCurrentParent=_pRoot;
      created=true;
      break;
    case GROUP:
      // Create group
      pChild=_pCurrentParent->AddGroup(pIDval);
      if(pChild)
        _pCurrentParent=pChild;
      created=true;
      break;
    case TESTCASE:
      // Create testcase
      pChild=_pCurrentParent->AddTestCase(pIDval);
      created=true;
      break;
    default:
      break;
  }
  if(pIDval)
    delete [] pIDval;
  pIDval=0;

  DEBUGCHK(pChild);

  do{
    if(!pChild)
      break;

    // Add more attributes
    std::list<MyElement>::iterator from=myelement.begin();
    for(;from!=myelement.end();++from){
      switch(g_ElemAttrMap[(*from).index].attrenum){
        case ID:
          break;
        case NAME:
          pChild->TestCaseName((*from).attrvalue);
          break;
        case RELEASE:
          break;
        case MAXRUNTIME:
        {
          int time=atoi((*from).attrvalue);
          pChild->MaxTimeLimit(time);
          break;
        }
        case PROFILING:
          break;
        case BLOCK:
          if(!stricmp((*from).attrvalue,"FALSE"))
            pChild->BlockStatus(FALSE);
          else
            pChild->BlockStatus(TRUE);
          break;
        case REINITIALIZEDATA:
          break;
        case STOPONFIRSTFAILURE:
          break;
        case EXECPATH:
          pChild->TestCaseExec((*from).attrvalue);
          break;
        case NUMRUNS:
        {
          int time=atoi((*from).attrvalue);
          pChild->NumberOfRuns(time);
          break;
        }
        default:
          break;
      }
      XMLString::release(&(*from).attrvalue);
    }
    pChild=0;
    myelement.clear();
  }while(0);

  return;
}

//-----------------------------------------------------------------------------
// GetScenario
//-----------------------------------------------------------------------------
TestCaseInfo
*XMLParse::GetScenario(void){
  return(_pRoot);
}
