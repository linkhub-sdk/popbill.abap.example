*&---------------------------------------------------------------------*
*& Report  ZPB_EX_HT_LISTACTIVEJOB
*&
*&---------------------------------------------------------------------*
*& 수집 요청건들에 대한 상태 목록을 확인합니다.
*& - 수집 요청 작업아이디(JobID)의 유효시간은 1시간 입니다.
*& - 응답항목에 관한 정보는 "[홈택스 전자(세금)계산서 연계 API 연동매뉴얼]
*&  > 3.2.3. ListActiveJob (수집 상태 목록 확인)" 을 참고하시기 바랍니다.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_HT_LISTACTIVEJOB.

DATA: lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lt_jobList type ZPOPBILL_HT_TAXINVOICE=>T_HT_TAXINVOICE_JOBSTATE,
      lv_job type ZPOPBILL_HT_TAXINVOICE=>S_HT_TAXINVOICE_JOBSTATE,
      lv_corpnum type String,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '6798700433'.


CALL METHOD lo_popbill_hometax->LISTACTIVEJOB
  EXPORTING
    p_corpNum = lv_corpnum
  IMPORTING
    P_JOBLIST = lt_JobList
    p_result  = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.

loop at lt_jobList into lv_Job.
write: /
  lv_job-JOBID,
  lv_job-JOBSTATE,
  LV_JOB-REGDT.

endloop.
