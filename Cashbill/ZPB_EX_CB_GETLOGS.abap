*&---------------------------------------------------------------------*
*& Report  ZPB_EX_CB_GETLOGS
*&
*&---------------------------------------------------------------------*
*&
*& 현금영수증 처리 이력을 확인.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_CB_GETLOGS.



DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_CASHBILL.


CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type String,
      lv_mgtkey type String,
      lv_Cashbill_logs TYPE ZPOPBILL_CASHBILL=>T_CASHBILL_LOG,
      lv_cashbill_log TYPE ZPOPBILL_CASHBILL=>S_CASHBILL_LOG,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '6798700433'.
* 확인할 현금영수증 관리번호.
lv_mgtkey = '20190819-002'.

CALL METHOD lo_popbill_hometax->GetLogs
  EXPORTING
    p_corpNum = lv_corpnum
    p_mgtKey = lv_mgtkey
  IMPORTING
    p_cashbill_log = lv_cashbill_logs
    p_result  = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.


 write: /
       'CASHBILL_LOGS'.
loop at lv_cashbill_logs into lv_cashbill_log.
 write: /
       'docLogType : ' , lv_cashbill_log-docLogType , ', log : ' , lv_cashbill_log-log , ', procType : ' , lv_cashbill_log-procType , ', procMemo : ' , lv_cashbill_log-procMemo , ', regDT : ' , lv_cashbill_log-regDT , ', ip : ' , lv_cashbill_log-ip .

endloop.