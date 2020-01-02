*&---------------------------------------------------------------------*
*& Report  ZPB_EX_CB_GETINFOS
*&
*&---------------------------------------------------------------------*
*&
*& 다수의 건의 상태 확인
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_CB_GETINFOS.



DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_CASHBILL.
DATA: lv_inuse type boolean.


CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type String,
      lv_mgtkey_list type ZPOPBILL_CASHBILL=>T_MGTKEYS,
      lv_Cashbill_info_list TYPE ZPOPBILL_CASHBILL=>T_CASHBILL_INFO,
      lv_Cashbill_Info TYPE ZPOPBILL_CASHBILL=>S_CASHBILL_INFO,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '6798700433'.

* 확인할 현금영수증 관리번호.추가
append '20190819-002' to lv_mgtkey_list .
append '20190819-003' to lv_mgtkey_list .

CALL METHOD lo_popbill_hometax->GetInfos
  EXPORTING
    p_corpNum = lv_corpnum
    p_mgtKey_list = lv_mgtkey_list
  IMPORTING
    p_cashbill_info_list = lv_cashbill_info_list
    p_result  = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.

loop at lv_cashbill_info_list into lv_cashbill_info.
 write: /
       'CASHBILL_INFO',/,
       'itemKey : ' , lv_cashbill_info-itemKey,/,
       'mgtKey : ' , lv_cashbill_info-mgtKey,/,
       'tradeDate : ' , lv_cashbill_info-tradeDate,/,
       'issueDT : ' , lv_cashbill_info-issueDT,/,
       'customerName : ' , lv_cashbill_info-customerName,/,
       'itemName : ' , lv_cashbill_info-itemName,/,
       'identityNum : ' , lv_cashbill_info-identityNum,/,
       'taxationType : ' , lv_cashbill_info-taxationType,/,
       'totalAmount : ' , lv_cashbill_info-totalAmount,/,
       'tradeUsage : ' , lv_cashbill_info-tradeUsage,/,
       'tradeOpt : ' , lv_cashbill_info-tradeOpt,/,
       'tradeType : ' , lv_cashbill_info-tradeType,/,
       'stateCode : ' , lv_cashbill_info-stateCode,/,
       'stateDT : ' , lv_cashbill_info-stateDT,/,
       'printYN : ' , lv_cashbill_info-printYN,/,
       'confirmNum : ' , lv_cashbill_info-confirmNum,/,
       'orgTradeDate : ' , lv_cashbill_info-orgTradeDate,/,
       'orgConfirmNum : ' , lv_cashbill_info-orgConfirmNum,/,
       'ntssendDT : ' , lv_cashbill_info-ntssendDT,/,
       'ntsresult : ' , lv_cashbill_info-ntsresult,/,
       'ntsresultDT : ' , lv_cashbill_info-ntsresultDT,/,
       'ntsresultCode : ' , lv_cashbill_info-ntsresultCode,/,
       'ntsresultMessage : ' , lv_cashbill_info-ntsresultMessage,/,
       'regDT : ' , lv_cashbill_info-regDT,/,
       'stateMemo : ' , lv_cashbill_info-stateMemo.
 endloop.