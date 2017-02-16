*&---------------------------------------------------------------------*
*& Report  ZPB_EX_REGISTCONTACT
*&
*&---------------------------------------------------------------------*
*& 팝빌 담당자 추가 예제.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_REGISTCONTACT.

DATA:
      lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type string,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT,
      lv_contactinfo type ZPOPBILL=>S_PB_CONTACTINFO.

*회원 사업자번호
lv_corpnum = '1231212312'.

*추가 담당자 아이디
lv_contactinfo-id = 'newid'.
*추가 담당자 비밀번호
lv_contactinfo-pwd = 'newpwd'.
*추가 담당자 이메일주소
lv_contactinfo-email = 'new@test.com'.
* 추가 담당자 연락처
lv_contactinfo-tel = '07043042990'.
* 추가 담당자명
lv_contactinfo-personName = '김성준'.
*추가 담당자 팩스번호
lv_contactInfo-fax = '07011112222'.
*추가 담당자 휴대전화
LV_CONTACTINFO-hp = '01012341234'.



call method LO_POPBILL_HOMETAX->REGISTCONTACT
  EXPORTING
    p_corpnum = lv_corpnum
    p_contactinfo = lv_contactinfo
  IMPORTING
    p_result = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
