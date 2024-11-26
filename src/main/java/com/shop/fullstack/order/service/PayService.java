package com.shop.fullstack.order.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@Service
public class PayService {

	@Autowired
	private IamportClient ic;

    public IamportResponse<Payment> paymentByImpUid(String impUid) throws IamportResponseException, IOException {
        return ic.paymentByImpUid(impUid);
    }

    public IamportResponse<Payment> cancelPayment(CancelData cancelData) throws IamportResponseException, IOException {
        return ic.cancelPaymentByImpUid(cancelData);
    }
}