*&---------------------------------------------------------------------*
*& Report  ZPB_EX_CHECKCORPNUMS
*&
*&---------------------------------------------------------------------*
*& 팝빌 사업자 상태조회 - 다량
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_CHECKCORPNUMS.

DATA: lo_popbill_cd TYPE REF TO ZPOPBILL_CLOSEDOWN.

CREATE OBJECT lo_popbill_cd
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_cd->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type String,
      lv_targetCorpNum type String_TABLE,
      lv_t_corpstate TYPE ZPOPBILL_CLOSEDOWN=>T_S_CORPSTATE,
      lv_corpstate TYPE ZPOPBILL_CLOSEDOWN=>S_CORPSTATE,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 회원 사업자번호
lv_corpnum = '1234567890'.

*  확인할 사업자번호 - 최대 1,000건.
append '1231212312' to lv_targetCorpNum.
append '6798700433' to lv_targetCorpNum.


CALL METHOD lo_popbill_cd->CHECKCORPNUMS
  EXPORTING
    p_corpNum = lv_corpnum
    p_t_targetcorpNUm = lv_targetCorpNum
  IMPORTING
    p_t_corpstate = lv_t_corpstate
    p_result  = lv_result.

write: /
      'RESULT Code : ',
      lv_result-code.
write: /
      'RERSULT Message : ',
      lv_result-message.

loop at lv_t_corpstate into lv_corpstate.
  write: /
      'STATE : ',
      lv_corpstate-corpnum,
      lv_corpstate-taxType,
      lv_corpstate-state,
      lv_corpstate-stateDate,
      lv_corpstate-checkDate.
  endloop.
