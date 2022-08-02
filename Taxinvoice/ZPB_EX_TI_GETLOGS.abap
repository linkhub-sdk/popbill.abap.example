*&---------------------------------------------------------------------*
*& Report  ZPB_EX_TI_GETLOGS
*&
*&---------------------------------------------------------------------*
*&
*& 세금계산서 문서이력 확인
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_TI_GETLOGS.


DATA: lo_popbill_taxinvoice TYPE REF TO ZPOPBILL_TAXINVOICE.

* 발급받은  LinkID 와 SecretKey 설정.
CREATE OBJECT lo_popbill_taxinvoice
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

* 테스트 베드로 연결설정.
lo_popbill_taxinvoice->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type String,
      lv_mgtkeyType TYPE ZPOPBILL_TAXINVOICE=>MGTKEYTYPE,
      lv_mgtkey type String,
      lv_Taxinvoice_log_list TYPE ZPOPBILL_TAXINVOICE=>T_TAXINVOICE_LOG,
      lv_taxinvoice_log TYPE ZPOPBILL_TAXINVOICE=>S_TAXINVOICE_LOG,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 확인할 회원 사업자번호
lv_corpnum = '1234567890'.
* 확인할 세금계산서 관리번호 유형
lv_mgtkeytype = ZPOPBILL_TAXINVOICE=>SELL.
* 확인할 현금영수증 관리번호.
lv_mgtkey = '20220718-ABAP001'.


CALL METHOD lo_popbill_taxinvoice->GetLogs
  EXPORTING
    p_corpNum = lv_corpnum
    p_mgtKeyType = lv_mgtkeytype
    p_mgtKey = lv_mgtkey
  IMPORTING
    p_taxinvoice_log_list = lv_taxinvoice_log_list
    p_result  = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
loop at lv_taxinvoice_log_list into lv_taxinvoice_log.
  write: /
      'TAXINVOICE_LOG',/,
      'docLogType : ' , lv_taxinvoice_log-docLogType,/,
      'log : ' , lv_taxinvoice_log-log,/,
      'procType : ' , lv_taxinvoice_log-procType,/,
      'procCorpName : ' , lv_taxinvoice_log-procCorpName,/,
      'procContactName : ' , lv_taxinvoice_log-procContactName,/,
      'procMemo : ' , lv_taxinvoice_log-procMemo,/,
      'regDT : ' , lv_taxinvoice_log-regDT,/,
      'ip : ' , lv_taxinvoice_log-ip.
endloop.
