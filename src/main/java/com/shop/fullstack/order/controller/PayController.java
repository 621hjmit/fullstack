package com.shop.fullstack.order.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;

import com.shop.fullstack.order.service.OrderService;
import com.shop.fullstack.order.service.PayService;
import com.shop.fullstack.order.service.PaymentInfoService;
import com.shop.fullstack.order.vo.OrdersVO;
import com.shop.fullstack.order.vo.PaymentInfoVO;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class PayController {
	
	@Autowired
	private PayService ps;
	
	@Autowired
	private PaymentInfoService paymentInfoService;
	
	@Autowired
	private OrderService orderService;

	@PostMapping("/api/payments/verify/{impUid}")
	public ResponseEntity<?> succeedPay(@PathVariable String impUid) {
		log.info("넘어옴?");
		try {
			IamportResponse<Payment> payment = ps.paymentByImpUid(impUid);
			Payment rsp = payment.getResponse();  // rsp 결제 결과 Data가 담긴 객체 
			log.info("payment: {}", payment);
			log.info("impUid: {}", impUid);
			log.info("rsp: {}", rsp);
			
			PaymentInfoVO payInfo = new PaymentInfoVO();
			OrdersVO order = new OrdersVO();
			
			// 결제 성공 시 payment_info 데이터 insert!!!!
			int idx = rsp.getMerchantUid().lastIndexOf("_");
            int uiNum = Integer.parseInt(rsp.getMerchantUid().substring(idx+1));
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            
            payInfo.setUiNum(uiNum);
            payInfo.setPayPg(rsp.getPgProvider());
            payInfo.setPayImpUid(rsp.getImpUid());
            payInfo.setPayMethod(rsp.getPayMethod());
            payInfo.setOrId(rsp.getMerchantUid());
            payInfo.setOrPiName(rsp.getName());
            payInfo.setPayAmount(rsp.getAmount().intValue());
            payInfo.setPayName(rsp.getBuyerName());
            payInfo.setPayEmail(rsp.getBuyerEmail());
            payInfo.setPayTel(rsp.getBuyerTel());
            payInfo.setPayStatus(rsp.getStatus());
            payInfo.setPayDate(dateFormat.format(rsp.getPaidAt()));
            
            int resultSavePayment = paymentInfoService.insertPayinfo(payInfo);
            if(resultSavePayment==1) {
            	log.info("결제정보저장 성공:{}",resultSavePayment);
            	// 결제정보가 저장되면 order table에 pay 정보 갱신
                order.setPayNum(payInfo.getPayNum());
                order.setPayName(payInfo.getPayName());
                order.setPayMethod("Card");
                order.setOrStatusPay("paid");
                order.setOrId(rsp.getMerchantUid());
                int resultUpdateOrder = orderService.updateOrderPay(order);
                if(resultUpdateOrder==1) {
                	log.info("주문 테이블에 결제정보 갱신성공:{}",resultUpdateOrder);
                }else {
                	log.info("주문 테이블에 결제정보 갱신실패:{}", resultUpdateOrder);
                }
            }else {
            	log.info("결제정보저장 실패:{}",resultSavePayment);
            }
            log.info("결제 성공: {}", payment);
			return ResponseEntity.ok(payment);
			
		} catch (Exception e) {
			log.error("결제 검증 실패: {}", e.getMessage());
			return ResponseEntity.badRequest().body(e.getMessage());
		}
	}

    @PostMapping("/api/payments/cancel")
    public ResponseEntity<?> cancelPayment(@RequestBody CancelData cancelData) {
        try {
            IamportResponse<Payment> canceledPayment = ps.cancelPayment(cancelData);
            return ResponseEntity.ok(canceledPayment);
        } catch (Exception e) {
            log.error("결제 취소 실패: {}", e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}