*&---------------------------------------------------------------------*
*& Report  ZPB_EX_LISTCONTACT
*&
*&---------------------------------------------------------------------*
*& 팝빌 회원 담당자 목록 확인.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_LISTCONTACT.

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
      lv_contactlist type ZPOPBILL=>T_PB_CONTACTINFO,
      lv_contact type ZPOPBILL=>S_PB_CONTACTINFO.

* 확인할 회원 사업자등록번호.
lv_corpnum = '1231212312'.

CALL METHOD LO_POPBILL_HOMETAX->listcontact
  EXPORTING
    p_corpnum     = lv_corpnum
  IMPORTING
    p_contactlist = lv_contactlist
    p_result      = lv_result.


write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.

write : / '---------------담당자 목록-----------------'.

loop at lv_contactlist into lv_contact.
  write: /
          lv_contact-personname,
          lv_contact-id,
          lv_contact-pwd,
          lv_contact-email,
          lv_contact-hp,
          lv_contact-tel,
          lv_contact-fax,
          lv_contact-mgryn,
          lv_contact-regdt.
endloop.
