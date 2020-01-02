*&---------------------------------------------------------------------*
*& Report  ZPB_EX_CB_GETDETAILINFO
*&
*&---------------------------------------------------------------------*
*&
*& 현금영수증 상세정보 확인
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_CB_GETDETAILINFO.



DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_CASHBILL.
DATA: lv_inuse type boolean.


CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type String,
      lv_mgtkey type String,
      lv_Cashbill TYPE ZPOPBILL_CASHBILL=>S_CASHBILL,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '6798700433'.
* 확인할 현금영수증 관리번호.
lv_mgtkey = '20190819-002'.

CALL METHOD lo_popbill_hometax->GetDetailInfo
  EXPORTING
    p_corpNum = lv_corpnum
    p_mgtKey = lv_mgtkey
  IMPORTING
    p_cashbill = lv_cashbill
    p_result  = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
write: /
      'CASHBILL',/,
      'memo : ' , lv_cashbill-memo,/,
      'mgtKey : ' , lv_cashbill-mgtKey,/,
      'tradeDate : ' , lv_cashbill-tradeDate,/,
      'tradeUsage : ' , lv_cashbill-tradeUsage,/,
      'tradeOpt : ' , lv_cashbill-tradeOpt,/,
      'tradeType : ' , lv_cashbill-tradeType,/,

      'taxationType : ' , lv_cashbill-taxationType,/,
      'supplyCost : ' , lv_cashbill-supplyCost,/,
      'tax : ' , lv_cashbill-tax,/,
      'serviceFee : ' , lv_cashbill-serviceFee,/,
      'totalAmount : ' , lv_cashbill-totalAmount,/,

      'franchiseCorpNum : ' , lv_cashbill-franchiseCorpNum,/,
      'franchiseCorpName : ' , lv_cashbill-franchiseCorpName,/,
      'franchiseCEOName : ' , lv_cashbill-franchiseCEOName,/,
      'franchiseAddr : ' , lv_cashbill-franchiseAddr,/,
      'franchiseTEL : ' , lv_cashbill-franchiseTEL,/,

      'identityNum : ' , lv_cashbill-identityNum,/,
      'customerName : ' , lv_cashbill-customerName,/,
      'itemName : ' , lv_cashbill-itemName,/,
      'orderNumber : ' , lv_cashbill-orderNumber,/,

      'email : ' , lv_cashbill-email,/,
      'hp : ' , lv_cashbill-hp,/,
      'fax : ' , lv_cashbill-fax,/,
      'faxsendYN : ' , lv_cashbill-faxsendYN,/,
      'smssendYN : ' , lv_cashbill-smssendYN,/,

      'confirmNum : ' , lv_cashbill-confirmNum,/,
      'orgConfirmNum : ' , lv_cashbill-orgConfirmNum,/,
      'orgTradeDate : ' , lv_cashbill-orgTradeDate,/,

      'cancelType : ' , lv_cashbill-cancelType,/,
      'emailSubject : ' , lv_cashbill-emailSubject.