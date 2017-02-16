*&---------------------------------------------------------------------*
*& Report  ZPB_EX_HT_GETJOBSTATE
*&
*&---------------------------------------------------------------------*
*& 팝빌 홈택스 세금계산서 수집작업 상태 확인.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_HT_GETJOBSTATE.

DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_jobState type ZPOPBILL_HT_TAXINVOICE=>S_HT_TAXINVOICE_JOBSTATE,
      lv_corpnum type String,
      lv_jobId   type String,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '6798700433'.

* 확인할 작업ID
lv_jobID = '016112315000000001'.

CALL METHOD lo_popbill_hometax->GETJOBSTATE
  EXPORTING
    p_corpNum = lv_corpnum
    P_JOBID = LV_JOBID
  IMPORTING
    P_JOBSTATE = lv_jobState
    p_result  = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
write: /
      'Job State Info',
       lv_jobState-JOBSTATE,
       LV_JOBSTATE-ERRORCODE,
       LV_JOBSTATE-ERRORREASON.
