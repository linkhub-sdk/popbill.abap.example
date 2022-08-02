*&---------------------------------------------------------------------*
*& Report  ZPB_EX_TI_GETDETAILINFO
*&
*&---------------------------------------------------------------------*
*&
*& 세금계산서 정보 확인.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_TI_GETDETAILINFO.


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
      lv_Taxinvoice TYPE ZPOPBILL_TAXINVOICE=>S_TAXINVOICE,
      lv_Taxinvoice_detail TYPE ZPOPBILL_TAXINVOICE=>S_TAXINVOICE_DETAIL,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '1234567890'.
* 확인할 세금계산서 관리번호 유형
lv_mgtkeytype = ZPOPBILL_TAXINVOICE=>SELL.
* 확인할 세금계산서 관리번호.
lv_mgtkey = '20220718-ABAP001'.


CALL METHOD lo_popbill_taxinvoice->GetDetailInfo
  EXPORTING
    p_corpNum = lv_corpnum
    p_mgtKeyType = lv_mgtkeytype
    p_mgtKey = lv_mgtkey
  IMPORTING
    p_taxinvoice = lv_taxinvoice
    p_result  = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
write: /
       'TAXINVOICE',/,
       'ntsconfirmNum : ' , lv_taxinvoice-ntsconfirmNum,/,
       'issueType : ' , lv_taxinvoice-issueType,/,
       'taxType : ' , lv_taxinvoice-taxType,/,
       'chargeDirection : ' , lv_taxinvoice-chargeDirection,/,
       'serialNum : ' , lv_taxinvoice-serialNum,/,
       'kwon : ' , lv_taxinvoice-kwon,/,
       'ho : ' , lv_taxinvoice-ho,/,
       'writeDate : ' , lv_taxinvoice-writeDate,/,
       'purposeType : ' , lv_taxinvoice-purposeType,/,
       'supplyCostTotal : ' , lv_taxinvoice-supplyCostTotal,/,
       'taxTotal : ' , lv_taxinvoice-taxTotal,/,
       'totalAmount : ' , lv_taxinvoice-totalAmount,/,
       'cash : ' , lv_taxinvoice-cash,/,
       'chkbill : ' , lv_taxinvoice-chkbill,/,
       'credit : ' , lv_taxinvoice-credit,/,
       'note : ' , lv_taxinvoice-note,/,
       'remark1 : ' , lv_taxinvoice-remark1,/,
       'remark2 : ' , lv_taxinvoice-remark2,/,
       'remark3 : ' , lv_taxinvoice-remark3,/,

       'invoicerMgtKey : ' , lv_taxinvoice-invoicerMgtKey,/,
       'invoicerCorpNum : ' , lv_taxinvoice-invoicerCorpNum,/,
       'invoicerTaxRegID : ' , lv_taxinvoice-invoicerTaxRegID,/,
       'invoicerCorpName : ' , lv_taxinvoice-invoicerCorpName,/,
       'invoicerCEOName : ' , lv_taxinvoice-invoicerCEOName,/,
       'invoicerAddr : ' , lv_taxinvoice-invoicerAddr,/,
       'invoicerBizType : ' , lv_taxinvoice-invoicerBizType,/,
       'invoicerBizClass : ' , lv_taxinvoice-invoicerBizClass,/,
       'invoicerContactName : ' , lv_taxinvoice-invoicerContactName,/,
       'invoicerDeptName : ' , lv_taxinvoice-invoicerDeptName,/,
       'invoicerTEL : ' , lv_taxinvoice-invoicerTEL,/,
       'invoicerHP : ' , lv_taxinvoice-invoicerHP,/,
       'invoicerEmail : ' , lv_taxinvoice-invoicerEmail,/,
       'invoicerSMSSendYN : ' , lv_taxinvoice-invoicerSMSSendYN,/,

       'invoiceeMgtKey : ' , lv_taxinvoice-invoiceeMgtKey,/,
       'invoiceeType : ' , lv_taxinvoice-invoiceeType,/,
       'invoiceeCorpNum : ' , lv_taxinvoice-invoiceeCorpNum,/,
       'invoiceeTaxRegID : ' , lv_taxinvoice-invoiceeTaxRegID,/,
       'invoiceeCorpName : ' , lv_taxinvoice-invoiceeCorpName,/,
       'invoiceeCEOName : ' , lv_taxinvoice-invoiceeCEOName,/,
       'invoiceeAddr : ' , lv_taxinvoice-invoiceeAddr,/,
       'invoiceeBizType : ' , lv_taxinvoice-invoiceeBizType,/,
       'invoiceeBizClass : ' , lv_taxinvoice-invoiceeBizClass,/,
       'invoiceeContactName1 : ' , lv_taxinvoice-invoiceeContactName1,/,
       'invoiceeDeptName1 : ' , lv_taxinvoice-invoiceeDeptName1,/,
       'invoiceeTEL1 : ' , lv_taxinvoice-invoiceeTEL1,/,
       'invoiceeHP1 : ' , lv_taxinvoice-invoiceeHP1,/,
       'invoiceeEmail1 : ' , lv_taxinvoice-invoiceeEmail1,/,
       'invoiceeContactName2 : ' , lv_taxinvoice-invoiceeContactName2,/,
       'invoiceeDeptName2 : ' , lv_taxinvoice-invoiceeDeptName2,/,
       'invoiceeTEL2 : ' , lv_taxinvoice-invoiceeTEL2,/,
       'invoiceeHP2 : ' , lv_taxinvoice-invoiceeHP2,/,
       'invoiceeEmail2 : ' , lv_taxinvoice-invoiceeEmail2,/,
       'invoiceeSMSSendYN : ' , lv_taxinvoice-invoiceeSMSSendYN,/,
       'closeDownState : ' , lv_taxinvoice-closeDownState,/,
       'closeDownStateDate : ' , lv_taxinvoice-closeDownStateDate,/,

       'trusteeMgtKey : ' , lv_taxinvoice-trusteeMgtKey,/,
       'trusteeCorpNum : ' , lv_taxinvoice-trusteeCorpNum,/,
       'trusteeTaxRegID : ' , lv_taxinvoice-trusteeTaxRegID,/,
       'trusteeCorpName : ' , lv_taxinvoice-trusteeCorpName,/,
       'trusteeCEOName : ' , lv_taxinvoice-trusteeCEOName,/,
       'trusteeAddr : ' , lv_taxinvoice-trusteeAddr,/,
       'trusteeBizType : ' , lv_taxinvoice-trusteeBizType,/,
       'trusteeBizClass : ' , lv_taxinvoice-trusteeBizClass,/,
       'trusteeContactName : ' , lv_taxinvoice-trusteeContactName,/,
       'trusteeDeptName : ' , lv_taxinvoice-trusteeDeptName,/,
       'trusteeTEL : ' , lv_taxinvoice-trusteeTEL,/,
       'trusteeHP : ' , lv_taxinvoice-trusteeHP,/,
       'trusteeEmail : ' , lv_taxinvoice-trusteeEmail,/,
       'trusteeSMSSendYN : ' , lv_taxinvoice-trusteeSMSSendYN,/,


       'modifyCode : ' , lv_taxinvoice-modifyCode,/,
       'orgNTSConfirmNum : ' , lv_taxinvoice-orgNTSConfirmNum,/,

       'businessLicenseYN : ' , lv_taxinvoice-businessLicenseYN,/,
       'bankBookYN : ' , lv_taxinvoice-bankBookYN.
loop at lv_taxinvoice-detailList into lv_taxinvoice_detail.
 write: /
      'TAXINVOICE-DETAIL',/,
      'serialNum : ' , lv_taxinvoice_detail-serialNum,/,
      'purchaseDT : ' , lv_taxinvoice_detail-purchaseDT,/,
      'itemName : ' , lv_taxinvoice_detail-itemName,/,
      'spec : ' , lv_taxinvoice_detail-spec,/,
      'qty : ' , lv_taxinvoice_detail-qty,/,
      'unitCost : ' , lv_taxinvoice_detail-unitCost,/,
      'supplyCost : ' , lv_taxinvoice_detail-supplyCost,/,
      'tax : ' , lv_taxinvoice_detail-tax,/,
      'remark : ' , lv_taxinvoice_detail-remark.
 endloop.
