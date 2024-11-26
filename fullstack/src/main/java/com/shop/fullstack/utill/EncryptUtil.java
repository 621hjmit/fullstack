package com.shop.fullstack.utill;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class EncryptUtil {
    private static final String salt = "LPO7QRSS";
    public static String encrypt(String str) {
        try {
            //sha 비번 암호화 하고 복호화 안되게
            str += salt;
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(str.getBytes());
            return Base64.getEncoder().encodeToString(md.digest());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }
}
