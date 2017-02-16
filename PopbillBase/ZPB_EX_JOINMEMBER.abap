*&---------------------------------------------------------------------*
*& Report  ZPB_EX_JOINMEMBER
*&
*&---------------------------------------------------------------------*
*& 팝빌 연동회원 가입 예제.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_JOINMEMBER.

DATA:
      lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA: lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT,
      lv_joinform type ZPOPBILL=>S_PB_JOINFORM.
* 파트너 링크아이디
LV_JOINFORM-LINKID = 'TESTER'.
* 신규회원 팝빌 아이디
LV_JOINFORM-ID = 'userid'.
* 회원 비밀번호
LV_JOINFORM-pwd = 'newPASSWORD'.
* 사업자번호 숫자 10자리
LV_JOINFORM-corpNum = '1231212312'.
* 상호
LV_JOINFORM-CORPNAME = '상호'.
* 대표자명
LV_JOINFORM-ceoName = '대표자성명'.
* 사업장 주소
LV_JOINFORM-addr = '사업장 주소'.
* 업태
LV_JOINFORM-BizType = '업태'.
* 종목
LV_JOINFORM-bizclass = '업종'.
* 담당자명
LV_JOINFORM-contactName = '담당자명'.
* 담당자 연락처
LV_JOINFORM-CONTACTTEL = '070-1111-2222'.
* 담당자 휴대전화
LV_JOINFORM-CONTACTHP = '010-0000-1111'.
* 담당자 팩스번호
LV_JOINFORM-CONTACTFAX = '070-2222-3333'.
* 담당자 이메일주소
LV_JOINFORM-CONTACTEMAIL = 'test@test.com'.

CALL METHOD lo_popbill_hometax->JOINMEMBER
  EXPORTING
    P_JOININFO = lv_joinForm
  IMPORTING
    p_result = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
