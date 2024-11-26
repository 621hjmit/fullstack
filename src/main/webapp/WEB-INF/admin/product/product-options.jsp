<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">

<!-- [ Main Content ] start -->
<div class="pc-container" style="background-color: #f8f9fa;">
    <div class="pc-content">
        <!-- [ breadcrumb ] start -->
        <div class="page-header py-3" >
            <div class="page-block">
                <div class="row align-items-center">
                    <div class="col-md-12">
                        <div class="page-header-title">
                            <h2 class="mb-0">제품 공통 정보 수정</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- [ breadcrumb ] end -->

        <!-- [ Main Content ] start -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card table-card shadow-sm">
                    <div class="card-body p-4">
                        <!-- 검색 조건 및 키워드 입력 부분 -->
                        <div class="row g-3 align-items-center mb-4">
                            <div class="col-md-3 col-lg-2">
                                <label for="selectCondition" class="form-label" style="font-weight: bold;">옵션 선택</label>
                                <select id="selectCondition" class="form-select" aria-label="검색 조건 선택">
                                    <option value="" disabled selected>옵션 선택</option>
                                    <option value="1">추가정보</option>
                                    <option value="2">배송</option>
                                    <option value="3">결제 수단</option>
                                    <option value="4">교환/환불</option>
                                    <option value="5">선물 하기</option>
                                </select>
                            </div>
                            <div class="col-md-9 col-lg-10">
                                <!-- 텍스트 입력을 위한 textarea 또는 개별 리스트 항목을 추가할 수 있는 영역 -->
                                <textarea id="keyword" class="form-control border-2" style="display: none;" rows="10" placeholder="추가 정보를 입력하세요..."></textarea>
                                <div id="listContainer" class="list-group border rounded p-3" style="display: none;">
                                    <!-- JavaScript로 생성된 개별 입력 필드들이 여기에 추가됩니다. -->
                                </div>
                            </div>
                        </div>

                        <div class="text-end mt-4">
                            <button id="addButton" class="btn btn-outline-secondary btn-sm me-2" style="display: none;">
                                <i class="bi bi-plus-circle"></i> 항목 추가
                            </button>
                            <button id="saveButton" class="btn btn-primary btn-lg">
                                <i class="bi bi-save"></i> 저장
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- [ block3 : done ] end -->
    </div>
</div>
<!-- [ Main Content ] end -->

<script src='/static/js/product/product-options.js' defer></script>
<%@ include file="/WEB-INF/admin/common/footer.jsp"%>
