*&---------------------------------------------------------------------*
*& Report  ZPB_EX_TI_REGISTISSUE
*&
*&---------------------------------------------------------------------*
*&
*& 작성된 세금계산서 데이터를 팝빌에 저장과 동시에 발행(전자서명)하여 '발행완료' 상태로 처리합니다.
*& - 세금계산서 국세청 전송 정책 [https://docs.popbill.com/taxinvoice/ntsSendPolicy?lang=java]
*& - '발행완료'된 전자세금계산서는 국세청 전송 이전에 발행취소(CancelIssue API) 함수로 국세청 신고 대상에서 제외할 수 있습니다.
*& - 임시저장(Register API) 함수와 발행(Issue API) 함수를 한 번의 프로세스로 처리합니다.
*& - 세금계산서 발행을 위해서 공급자의 인증서가 팝빌 인증서버에 사전등록 되어야 합니다.
*&   └ 위수탁발행의 경우, 수탁자의 인증서 등록이 필요합니다.
*& https://docs.popbill.com/taxinvoice/java/api#RegistIssue
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_TI_REGISTISSUE.

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
      lv_taxinvoice type ZPOPBILL_TAXINVOICE=>S_TAXINVOICE,
      lv_taxinvoice_Detail type ZPOPBILL_TAXINVOICE=>S_TAXINVOICE_DETAIL,
      lv_taxinvoice_addcontact type ZPOPBILL_TAXINVOICE=>S_TAXINVOICE_ADDCONTACT,
      lv_memo type string,
      lv_forceIssue type boolean,
      lv_emailSubject type string,
      lv_ntsconfirmNum type String,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 회원 사업자번호
lv_corpnum = '1234567890'.

*  발행형태, {정발행, 역발행, 위수탁} 중 기재
lv_taxinvoice-IssueType = '정발행'.

*  과세형태, {과세, 영세, 면세} 중 기재
lv_taxinvoice-TaxType = '과세'.

*  과금방향, {정과금, 역과금} 중 기재
*  └ 정과금 = 공급자 과금 , 역과금 = 공급받는자 과금
*  -'역과금'은 역발행 세금계산서 발행 시에만 이용가능
lv_taxinvoice-ChargeDirection = '정과금'.

*  작성일자, 날짜형식(yyyyMMdd)
lv_taxinvoice-WriteDate = '20220718'.

*  {영수, 청구, 없음} 중 기재
lv_taxinvoice-PurposeType = '영수'.


***************************************************************************
*                               공급자 정보
***************************************************************************

*  공급자 사업자번호 (하이픈 '-' 제외 10 자리)
lv_taxinvoice-InvoicerCorpNum = lv_CorpNum.

*  공급자 종사업장 식별번호, 필요시 기재. 형식은 숫자 4자리.
lv_taxinvoice-InvoicerTaxRegID = '1234'.

*  공급자 상호
lv_taxinvoice-InvoicerCorpName = '공급자 상호'.

*  공급자 문서번호, 1~24자리 (숫자, 영문, '-' ) 조합으로 사업자 별로 중복되지 않도록 구성
lv_taxinvoice-InvoicerMgtKey = '20220718-ABAP001'.

*  공급자 대표자 성명
lv_taxinvoice-InvoicerCEOName = '공급자 대표자 성명'.

*  공급자 주소
lv_taxinvoice-InvoicerAddr = '공급자 주소'.

*  공급자 종목
lv_taxinvoice-InvoicerBizClass = '공급자 업종'.

*  공급자 업태
lv_taxinvoice-InvoicerBizType = '공급자 업태,업태2'.

*  공급자 담당자 성명
lv_taxinvoice-InvoicerContactName = '공급자 담당자 성명'.

*  공급자 담당자 메일주소
lv_taxinvoice-InvoicerEmail = 'test@test.com'.

*  공급자 담당자 연락처
lv_taxinvoice-InvoicerTEL = '070-7070-0707'.

*  공급자 담당자 휴대폰번호
lv_taxinvoice-InvoicerHP = '010-000-2222'.

*  발행 안내 문자 전송여부 (true / false 중 택 1)
*  └ true = 전송 , false = 미전송
*  └ 공급받는자 (주)담당자 휴대폰번호 {invoiceeHP1} 값으로 문자 전송
*  - 전송 시 포인트 차감되며, 전송실패시 환불처리
lv_taxinvoice-InvoicerSMSSendYN = abap_false.

***************************************************************************
*                               공급받는자 정보
****************************************************************************/

*  공급받는자 구분, [사업자, 개인, 외국인] 중 기재
lv_taxinvoice-InvoiceeType = '사업자'.

*  공급받는자 사업자번호
*  - {invoiceeType}이 '사업자' 인 경우, 사업자번호 (하이픈 ('-') 제외 10자리)
*  - {invoiceeType}이 '개인' 인 경우, 주민등록번호 (하이픈 ('-') 제외 13자리)
*  - {invoiceeType}이 '외국인' 인 경우, '9999999999999' (하이픈 ('-') 제외 13자리)
lv_taxinvoice-InvoiceeCorpNum = '8888888888'.

*  공급받는자 종사업장 식별번호, 필요시 숫자4자리 기재
lv_taxinvoice-InvoiceeTaxRegID = '4321'.

*  공급받는자 상호
lv_taxinvoice-InvoiceeCorpName = '공급받는자 상호'.

*  [역발행시 필수] 공급받는자 문서번호, 1~24자리 (숫자, 영문, '-') 를 조합하여 사업자별로 중복되지 않도록 구성
lv_taxinvoice-InvoiceeMgtKey = ''.

*  공급받는자 대표자 성명
lv_taxinvoice-InvoiceeCEOName = '공급받는자 대표자 성명'.

*  공급받는자 주소
lv_taxinvoice-InvoiceeAddr = '공급받는자 주소'.

*  공급받는자 종목
lv_taxinvoice-InvoiceeBizClass = '공급받는자 업종'.

*  공급받는자 업태
lv_taxinvoice-InvoiceeBizType = '공급받는자 업태'.

*  공급받는자 담당자 성명
lv_taxinvoice-InvoiceeContactName1 = '공급받는자 담당자 성명'.

*  공급받는자 담당자 메일주소
*  팝빌 개발환경에서 테스트하는 경우에도 안내 메일이 전송되므로,
*  실제 거래처의 메일주소가 기재되지 않도록 주의
lv_taxinvoice-InvoiceeEmail1 = 'test@invoicee.com'.

*  공급받는자 담당자 연락처
lv_taxinvoice-InvoiceeTEL1 = '070-111-222'.

*  공급받는자 담당자 휴대폰번호
lv_taxinvoice-InvoiceeHP1 = '010-111-222'.

*  역발행 안내 문자 전송여부 (true / false 중 택 1)
*  └ true = 전송 , false = 미전송
*  └ 공급자 담당자 휴대폰번호 {invoicerHP} 값으로 문자 전송
*  - 전송 시 포인트 차감되며, 전송실패시 환불처리
lv_taxinvoice-InvoiceeSMSSendYN = abap_false.

***************************************************************************
*                              세금계산서 기재정보
****************************************************************************/

*  공급가액 합계 ( 수정세금계산서 발행시와 같이 마이너스 금액 입력시에는 부호가 앞에 표시됨을 주의. ex '-1000000')
lv_taxinvoice-SupplyCostTotal = '100000'.

*  세액 합계 ( 수정세금계산서 발행시와 같이 마이너스 금액 입력시에는 부호가 앞에 표시됨을 주의. ex '-1000000')
lv_taxinvoice-TaxTotal = '10000'.

*  합계금액, 공급가액 + 세액 ( 수정세금계산서 발행시와 같이 마이너스 금액 입력시에는 부호가 앞에 표시됨을 주의. ex '-1000000')
lv_taxinvoice-TotalAmount = '110000'.

*  일련번호
lv_taxinvoice-SerialNum = '123'.

*  현금
lv_taxinvoice-Cash = '50000'.

*  수표
lv_taxinvoice-ChkBill = '50000'.

*  어음
lv_taxinvoice-Note = '5000'.

*  외상미수금
lv_taxinvoice-Credit = '5000'.

*  비고
*  {invoiceeType}이 '외국인' 이면 remark1 필수
*  - 외국인 등록번호 또는 여권번호 입력
lv_taxinvoice-Remark1 = '비고1'.
lv_taxinvoice-Remark2 = '비고2'.
lv_taxinvoice-Remark3 = '비고3'.

*  책번호 '권' 항목, 최대값 32767
lv_taxinvoice-kwon = '1'.

*  책번호 '호' 항목, 최대값 32767
lv_taxinvoice-Ho = '1'.

*  사업자등록증 이미지 첨부여부 (true / false 중 택 1)
*  └ true = 첨부 , false = 미첨부(기본값)
*  - 팝빌 사이트 또는 인감 및 첨부문서 등록 팝업 URL (GetSealURL API) 함수를 이용하여 등록
lv_taxinvoice-BusinessLicenseYN = abap_false.

*  통장사본 이미지 첨부여부 (true / false 중 택 1)
*  └ true = 첨부 , false = 미첨부(기본값)
*  - 팝빌 사이트 또는 인감 및 첨부문서 등록 팝업 URL (GetSealURL API) 함수를 이용하여 등록
lv_taxinvoice-BankBookYN = abap_false.

***************************************************************************
* 수정세금계산서 정보 (수정세금계산서 작성시에만 기재)
* - 수정세금계산서 작성방법 안내 - https:* docs.popbill.com/taxinvoice/modify?lang=java
****************************************************************************/

*  수정사유코드, 수정사유에 따라 1~6 중 선택기재.
lv_taxinvoice-ModifyCode = 0.

*  수정세금계산서 작성시 원본세금계산서 국세청 승인번호 기재
lv_taxinvoice-OrgNTSConfirmNum = ''.


***************************************************************************
*                               상세항목 기재. 최대 99개 지원.
* - 상세항목의 세액(tax)의 합계는 기재항목중 taxTotal과 같아야 함.
***************************************************************************

* 상세항목 일련번호 1로 시작. 최대 99개 까지만 허용됨.
lv_taxinvoice_detail-serialNum = 1.
* 상세항목 거래일자
lv_taxinvoice_detail-purchaseDT = '20220718'.
*  상세항목 품목명
lv_taxinvoice_detail-itemName = '품목명1'.
* 상세항목 규격
lv_taxinvoice_detail-spec = '규격'.
* 상세항목 수량. (소수점 2자리 까지 사용가능)
lv_taxinvoice_detail-qty = '10.01'.
* 상세항목 단가. (소수점 2자리 까지 사용가능)
lv_taxinvoice_detail-unitcost = '100.05'.
* 상세항목 공급가액.  ( 수정세금계산서 발행시와 같이 마이너스 금액 입력시에는 부호가 앞에 표시됨을 주의. ex '-1000000')
lv_taxinvoice_detail-supplyCost = '100000'.
* 상세항목 세액
lv_taxinvoice_detail-tax = '10000'.
* 상세항목 비고
lv_taxinvoice_detail-remark = '비고'.

append lv_taxinvoice_Detail to lv_taxinvoice-detailList.
clear lv_taxinvoice_detail.

* 상세항목 2번 라인
lv_taxinvoice_detail-serialNum = 2.
lv_taxinvoice_detail-itemName = '품목명2'.
append lv_taxinvoice_Detail to lv_taxinvoice-detailList.



***************************************************************************
*                              추가 담당자. 발행시 안내메일을 추가 전송하는 용도.
***************************************************************************

* 추가담당자 일련번호 최대 5개 까지 허용.
lv_taxinvoice_addcontact-serialNum = 1.
* 추가담당자 이메일 주소
lv_taxinvoice_addcontact-email = 'test1@test.com'.
* 추가담당자 성명
lv_taxinvoice_addcontact-contactName = '추가담당자1'.

append lv_taxinvoice_addcontact to lv_taxinvoice-addcontactList.

clear lv_taxinvoice_addcontact.

* 두번째 추가 담당자
lv_taxinvoice_addcontact-serialNum = 2.
lv_taxinvoice_addcontact-email = 'test2@test.com'.
lv_taxinvoice_addcontact-contactName = '추가담당자2'.

append lv_taxinvoice_addcontact to lv_taxinvoice-addcontactList.

* 지연발행 강제발행 여부. 강제로 지연발행을 원할 경우 abap_true로 호출시 발행가능.
lv_forceIssue = abap_false.
* 기본 이메일 제목을 변경하고자 할 경우 기재.
lv_emailSubject = ''.

CALL METHOD lo_popbill_taxinvoice->RegistIssue
  EXPORTING
    p_corpNum  = lv_corpnum
    p_taxinvoice = lv_taxinvoice
    p_memo = lv_memo
    p_forceIssue = lv_forceIssue
    p_emailSubject = lv_emailSubject
  IMPORTING
    p_ntsconfirmNum = lv_ntsconfirmNum
    p_result   = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RESULT Message',
      lv_result-message.
write: /
      '국세청 승인번호' ,
      lv_ntsconfirmNum.
