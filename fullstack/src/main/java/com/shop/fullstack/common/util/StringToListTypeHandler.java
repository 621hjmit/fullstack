package com.shop.fullstack.common.util;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

public class StringToListTypeHandler extends BaseTypeHandler<List<String>> {

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, List<String> parameter, JdbcType jdbcType) throws SQLException {
        // List<String>을 쉼표로 연결된 문자열로 변환
        ps.setString(i, String.join(",", parameter));
    }

    @Override
    public List<String> getNullableResult(ResultSet rs, String columnName) throws SQLException {
        String value = rs.getString(columnName);
        // 쉼표로 구분된 문자열을 List<String>으로 변환
        return value != null ? Arrays.asList(value.split(",")) : null;
    }

    @Override
    public List<String> getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        String value = rs.getString(columnIndex);
        return value != null ? Arrays.asList(value.split(",")) : null;
    }

    @Override
    public List<String> getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        String value = cs.getString(columnIndex);
        return value != null ? Arrays.asList(value.split(",")) : null;
    }
}