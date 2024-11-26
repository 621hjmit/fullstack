<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>
    <!-- [ Main Content ] start -->
    <div class="pc-container">
      <div class="pc-content">
        <!-- [ breadcrumb ] start -->
        <div class="page-header">
          <div class="page-block">
            <div class="row align-items-center">
              <div class="col-md-12">
                <ul class="breadcrumb">
                  <li class="breadcrumb-item" aria-current="page"><a href="/admin">Home</a></li>
                </ul>
              </div>
              <div class="col-md-12">
                <div class="page-header-title">
                  <h2 class="mb-0">Home</h2>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- [ breadcrumb ] end -->
        <!-- [ Main Content ] start -->
        <div class="row">
          <!-- [ sample-page ] start -->
          <div class="col-md-4 col-sm-12">
            <div class="card statistics-card-1 overflow-hidden  bg-brand-color-3">
              <div class="card-body">
                <img src="/static/assets/images/widget/img-status-6.svg" alt="img" class="img-fluid img-bg" >
                <h5 class="mb-4 text-white">일별 매출 현황</h5>
                <div class="d-flex align-items-center mt-3">
                  <h3 class="text-white f-w-300 d-flex align-items-center m-b-0">&#8361;10,000,000</h3>
                </div>
                <dl class="row text-white mt-4 mb-0">
								  <dt class="col-sm-6">결제된 주문</dt>
								  <dd class="col-sm-6 text-end">100건</dd>
								  <dt class="col-sm-6">환불 (취소 및 반품)</dt>
								  <dd class="col-sm-6 text-end">
								    <p>10건</p>
								  </dd>
						  	</dl>
              </div>
            </div>
          </div>
          <div class="col-md-4 col-sm-6">
            <div class="card statistics-card-1 overflow-hidden">
              <div class="card-body">
                <img src="/static/assets/images/widget/img-status-4.svg" alt="img" class="img-fluid img-bg" >
                <h5 class="mb-4">월별 매출 현황</h5>
                <div class="d-flex align-items-center mt-3">
                  <h3 class="f-w-300 d-flex align-items-center m-b-0">&#8361;20,000,000</h3>
                </div>
                <h5 class="mb-4 mt-4">연간 매출 현황</h5>
                <div class="d-flex align-items-center mt-3">
                  <h3 class="f-w-300 d-flex align-items-center m-b-0">&#8361;30,000,000</h3>
                </div>
              </div>
            </div>
          </div>
          <div class="col-md-4 col-sm-6">
            <div class="card statistics-card-1 overflow-hidden ">
              <div class="card-body">
                <img src="/static/assets/images/widget/img-status-5.svg" alt="img" class="img-fluid img-bg" >
                <h5 class="mb-4">오늘 신규 회원</h5>
                <div class="d-flex align-items-center mt-3">
                  <h3 class="f-w-300 d-flex align-items-center m-b-0">100명</h3>
                </div>
                <h5 class="mb-4 mt-4">총 회원수</h5>
                <div class="d-flex align-items-center mt-3">
                  <h3 class="f-w-300 d-flex align-items-center m-b-0">30,000명</h3>
                </div>
              </div>
            </div>
          </div>
          <div class="col-xl-6 col-md-12">
            <div class="card">
              <div class="card-header d-flex align-items-center justify-content-between py-3">
                <h5 class="mb-0">1:1 문의</h5>
                <div class="dropdown">
                  <a
                    class="avtar avtar-s btn-link-secondary dropdown-toggle arrow-none"
                    href="#"
                    data-bs-toggle="dropdown"
                    aria-haspopup="true"
                    aria-expanded="false">
                    <i class="ti ti-dots-vertical f-18"></i>
                  </a>
                  <div class="dropdown-menu dropdown-menu-end">
                    <a class="dropdown-item" href="#">Today</a>
                    <a class="dropdown-item" href="#">Weekly</a>
                    <a class="dropdown-item" href="#">Monthly</a>
                  </div>
                </div>
              </div>
              <ul class="list-group list-group-flush border-top-0">
                <li class="list-group-item">
                  <div class="d-flex align-items-center">
                    <div class="flex-grow-1 me-2">
                      <h6 class="mb-0">단추 하나만 구매 가능한가요?</h6>
                      <p class="mt-1 mb-0"><i class="ti ti-user"></i> id-random</p>
                    </div>
                    <div class="flex-shrink-0">
                      <span class="badge bg-danger rounded-pill">미답변</span>
                    </div>
                  </div>
                </li>
                <li class="list-group-item">
                  <div class="d-flex align-items-center">
                    <div class="flex-grow-1 me-2">
                      <h6 class="mb-0">하나만 반품</h6>
                      <p class="mt-1 mb-0"><i class="ti ti-user"></i> id-random</p>
                    </div>
                    <div class="flex-shrink-0">
                      <span class="badge bg-success rounded-pill">답변 완료</span>
                    </div>
                  </div>
                </li>
                <li class="list-group-item">
                  <div class="d-flex align-items-center">
                    <div class="flex-grow-1 me-2">
                      <h6 class="mb-0">채우기 텍스트 1:1 문의 게시물</h6>
                      <p class="mt-1 mb-0"><i class="ti ti-user"></i> id-random</p>
                    </div>
                    <div class="flex-shrink-0">
                      <span class="badge bg-danger rounded-pill">미답변</span>
                    </div>
                  </div>
                </li>
              </ul>
            </div>
          </div>
          <div class="col-xl-6 col-md-12">
            <div class="card">
              <div class="card-header d-flex align-items-center justify-content-between py-3">
                <h5 class="mb-0">공지사항</h5>
                <div class="dropdown">
                  <a
                    class="avtar avtar-s btn-link-secondary dropdown-toggle arrow-none"
                    href="#"
                    data-bs-toggle="dropdown"
                    aria-haspopup="true"
                    aria-expanded="false"
                  >
                    <i class="ti ti-dots-vertical f-18"></i>
                  </a>
                  <div class="dropdown-menu dropdown-menu-end">
                    <a class="dropdown-item" href="#">Today</a>
                    <a class="dropdown-item" href="#">Weekly</a>
                    <a class="dropdown-item" href="#">Monthly</a>
                  </div>
                </div>
              </div>
              <ul class="list-group list-group-flush border-top-0">
                <li class="list-group-item">
                  <div class="d-flex align-items-center">
                    <div class="flex-grow-1 me-2">
                      <h6 class="mb-0">단추 하나만 구매 가능한가요?</h6>
                      <p class="mt-1 mb-0"><i class="ti ti-user"></i> id-random</p>
                    </div>
                    <div class="flex-shrink-0">
                      <span class="badge bg-danger rounded-pill">미답변</span>
                    </div>
                  </div>
                </li>
                <li class="list-group-item">
                  <div class="d-flex align-items-center">
                    <div class="flex-grow-1 me-2">
                      <h6 class="mb-0">하나만 반품</h6>
                      <p class="mt-1 mb-0"><i class="ti ti-user"></i> id-random</p>
                    </div>
                    <div class="flex-shrink-0">
                      <span class="badge bg-success rounded-pill">답변 완료</span>
                    </div>
                  </div>
                </li>
                <li class="list-group-item">
                  <div class="d-flex align-items-center">
                    <div class="flex-grow-1 me-2">
                      <h6 class="mb-0">채우기 텍스트 1:1 문의 게시물</h6>
                      <p class="mt-1 mb-0"><i class="ti ti-user"></i> id-random</p>
                    </div>
                    <div class="flex-shrink-0">
                      <span class="badge bg-danger rounded-pill">미답변</span>
                    </div>
                  </div>
                </li>
              </ul>
            </div>
          </div>
          
          <!-- [ sample-page ] end -->
        </div>
        <!-- [ Main Content ] end -->
      </div>
    </div>
    <!-- [ Main Content ] end -->
    <!-- [Page Specific JS] start -->
    <!-- [Page Specific JS] end -->
    
<%@ include file="/WEB-INF/admin/common/footer.jsp" %>