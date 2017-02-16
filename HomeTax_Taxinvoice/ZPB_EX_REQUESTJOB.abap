*&---------------------------------------------------------------------*
*& Report  ZPB_EX_HT_REQUESTJOB
*&
*&---------------------------------------------------------------------*
*&전자(세금)계산서 매출/매입 내역 수집을 요청합니다
*&- 매출/매입 연계 프로세스는 "[홈택스 전자(세금)계산서 연계 API 연동매뉴얼]
*&  > 1.2. 프로세스 흐름도" 를 참고하시기 바랍니다.
*&- 수집 요청후 반환받은 작업아이디(JobID)의 유효시간은 1시간 입니다.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_HT_REQUESTJOB.

DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type String,
      lv_queryType type string,
      lv_dtype type string,
      lv_sdate type d,
      lv_edate type d,
      lv_userid type string,
      lv_jobid  type string,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '6798700433'.

lv_queryType = ZPOPBILL_HT_TAXINVOICE=>QUERY_TYPE-SELL.
lv_dType = 'W'.

lv_Sdate = '20170101'.
lv_edate = '20170131'.

* lv_userid = 'userid'.

CALL METHOD lo_popbill_hometax->REQUESTJOB
  EXPORTING
    p_corpNum = lv_corpnum
    P_QUERYTYPE = lv_queryType
    P_DTYPE = lv_dtype
    P_SDATE = lv_sdate
    p_edate = lv_edate
    P_USERID = lv_userid
  IMPORTING
    P_JOBID   = lv_jobid
    p_result  = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
write: /
      'JobID is',
      lv_jobid.
