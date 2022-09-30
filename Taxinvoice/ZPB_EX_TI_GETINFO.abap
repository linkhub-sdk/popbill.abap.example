*&---------------------------------------------------------------------*
*& Report  ZPB_EX_TI_GETINFO
*&
*&---------------------------------------------------------------------*
*&
*& 세금계산서 발행상태 정보 확인. 발행상태 및 국세청 전송상태 확인용.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_TI_GETINFO.


DATA: lo_popbill_taxinvoice TYPE REF TO ZPOPBILL_TAXINVOICE.

* 발급받은  LinkID 와 SecretKey 설정.
CREATE OBJECT lo_popbill_taxinvoice
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

* 테스트 베드로 연결설정.
lo_popbill_taxinvoice->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type String,
      lv_mgtkeyType TYPE ZPOPBILL_TAXINVOICE=>MGTKEYTYPE,
      lv_mgtkey type String,
      lv_Taxinvoice_Info TYPE ZPOPBILL_TAXINVOICE=>S_TAXINVOICE_INFO,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '1234567890'.
* 확인할 세금계산서 관리번호 유형
lv_mgtkeytype = ZPOPBILL_TAXINVOICE=>SELL.
* 확인할 현금영수증 관리번호.
lv_mgtkey = '20220718-ABAP001'.


CALL METHOD lo_popbill_taxinvoice->GetInfo
  EXPORTING
    p_corpNum = lv_corpnum
    p_mgtKeyType = lv_mgtkeytype
    p_mgtKey = lv_mgtkey
  IMPORTING
    p_taxinvoice_info = lv_taxinvoice_info
    p_result  = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
write: /
      'TAXINVOICE_INFO',/,
      'itemKey : ' , lv_taxinvoice_info-itemKey,/,
      'taxType : ' , lv_taxinvoice_info-taxType,/,
      'writeDate : ' , lv_taxinvoice_info-writeDate,/,
      'regDT : ' , lv_taxinvoice_info-regDT,/,
      'invoicerCorpNum : ' , lv_taxinvoice_info-invoicerCorpNum,/,
      'invoicerCorpName : ' , lv_taxinvoice_info-invoicerCorpName,/,
      'invoicerMgtKey : ' , lv_taxinvoice_info-invoicerMgtKey,/,
      'invoicerPrintYN : ' , lv_taxinvoice_info-invoicerPrintYN,/,
      'invoiceeCorpNum : ' , lv_taxinvoice_info-invoiceeCorpNum,/,
      'invoiceeCorpName : ' , lv_taxinvoice_info-invoiceeCorpName,/,
      'invoiceeMgtKey : ' , lv_taxinvoice_info-invoiceeMgtKey,/,
      'invoiceePrintYN : ' , lv_taxinvoice_info-invoiceePrintYN,/,
      'closeDownState : ' , lv_taxinvoice_info-closeDownState,/,
      'closeDownStateDate : ' , lv_taxinvoice_info-closeDownStateDate,/,
      'trusteeCorpNum : ' , lv_taxinvoice_info-trusteeCorpNum,/,
      'trusteeCorpName : ' , lv_taxinvoice_info-trusteeCorpName,/,
      'trusteeMgtKey : ' , lv_taxinvoice_info-trusteeMgtKey,/,
      'trusteePrintYN : ' , lv_taxinvoice_info-trusteePrintYN,/,
      'supplyCostTotal : ' , lv_taxinvoice_info-supplyCostTotal,/,
      'taxTotal : ' , lv_taxinvoice_info-taxTotal,/,
      'purposeType : ' , lv_taxinvoice_info-purposeType,/,
      'modifyCode : ' , lv_taxinvoice_info-modifyCode,/,
      'issueType : ' , lv_taxinvoice_info-issueType,/,
      'issueDT : ' , lv_taxinvoice_info-issueDT,/,
      'preIssueDT : ' , lv_taxinvoice_info-preIssueDT,/,
      'stateCode : ' , lv_taxinvoice_info-stateCode,/,
      'stateDT : ' , lv_taxinvoice_info-stateDT,/,
      'openYN : ' , lv_taxinvoice_info-openYN,/,
      'openDT : ' , lv_taxinvoice_info-openDT,/,
      'ntsresult : ' , lv_taxinvoice_info-ntsresult,/,
      'ntsconfirmNum : ' , lv_taxinvoice_info-ntsconfirmNum,/,
      'ntssendDT : ' , lv_taxinvoice_info-ntssendDT,/,
      'ntsresultDT : ' , lv_taxinvoice_info-ntsresultDT,/,
      'ntssendErrCode : ' , lv_taxinvoice_info-ntssendErrCode,/,
      'stateMemo : ' , lv_taxinvoice_info-stateMemo,/,
      'lateIssueYN : ' , lv_taxinvoice_info-lateIssueYN,/,
      'interOPYN : ' , lv_taxinvoice_info-interOPYN.
