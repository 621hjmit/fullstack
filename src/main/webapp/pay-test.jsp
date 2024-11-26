<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
</head>
<body>
	<input type="text" id="goodsName" placeholder="상품명을 입력하세요" value="">
	<input type="text" id="goodsPrice" placeholder="가격을 입력하세요" value="">
	<input type="text" id="name" placeholder="이름을 입력하세요" value="">
	<input type="text" id="email" placeholder="이메일을 입력하세요" value="">
	<input type="text" id="phone" placeholder="전화번호를 입력하세요" value="">
	<input type="text" id="address" placeholder="주소를 입력하세요" value="">
    <button onclick="requestPay()">결제하기</button>
    
    <script>
    let user = '<c:out value="${user}"/>'
        var IMP = window.IMP;
        IMP.init('imp45375380'); // 가맹점 식별코드
        
        function requestPay() {
            IMP.request_pay({
                pg: "html5_inicis",
                pay_method: "card",
                merchant_uid: "ORD" + (new Date().getTime()) +"_" + ${user.uiId},  //
                name: document.querySelector('#goodsName').value,
                amount: document.querySelector('#goodsPrice').value,
                buyer_email: document.querySelector('#email').value,
                buyer_name: document.querySelector('#name').value,
                buyer_tel: document.querySelector('#phone').value,
                buyer_addr: document.querySelector('#address').value,
            }, function (rsp) {
                if (rsp.success) {
                    // 결제 성공 시 검증 요청
                    fetch('/api/payments/verify/' + rsp.imp_uid, {
                        method: 'POST'
                    })
                    .then(response => response.json())
                    .then(data => {
                        if(data.amount === rsp.paid_amount) {
                            alert('결제가 완료되었습니다.');
                        } else {
                            alert('결제 금액 불일치. 관리자에게 문의해주세요.');
                        }
                    });
                } else {
                    alert('결제에 실패하였습니다. ' + rsp.error_msg);
                }
            });
        }
    </script>
</body>
</html>