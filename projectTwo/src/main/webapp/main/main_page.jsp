<%@page import="xyz.nailro.dao.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.nailro.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%
	String url = request.getParameter("url");

	if(url!=null){
		request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?"+url);
	}
	
	List<ProductDTO> productList = ProductDAO.getDAO().selectNewProductList();
	
%>
<link href="<%=request.getContextPath()%>/css/main.css" type="text/css" rel="stylesheet">
<div class="sliderWrap">
    <div class="sliderImg">
        <div class="sliderInner">
            <div class="imageSlider s1">
	            <a href="<%=request.getContextPath()%>/index.jsp?group=product&worker=new">
	            	<img src="<%= request.getContextPath() %>/images/main_image.jpg" width="100%" height="600px">
	            </a>
            </div>
            <div class="imageSlider s2">
            	<a href="<%=request.getContextPath()%>/index.jsp?group=client&worker=client_terms">
           			<img src="<%= request.getContextPath() %>/images/newJoin.png" width="100%" height="600px">
           		</a>
           	</div>
        </div>
    </div>
</div>

<div class="new">
	<h2 style="display:inline;">이달의 신상품</h2>
	<div style="display:inline;" id="more"><a href="<%=request.getContextPath()%>/index.jsp?group=product&worker=new">+ 더보기</a></div>
</div>
<div class="container">
	<div class="prodList" id="prodList">
		<% for (int i=0; i<6; i++) { 
		    ProductDTO product= productList.get(i);
		    String productUrl = request.getContextPath() + "/index.jsp?group=detail&worker=detail&productNum=" + product.getProductNum();
		%>
		    <div class="product" >
		        <a href="<%=productUrl%>">
		            <img class="prodImage" src="<%=request.getContextPath() %>/<%=product.getProductImage()%>" alt="이미지 준비중" width="200px">
		        </a>
		        <div class="prodName">
		            <a href="<%=productUrl%>"><%=product.getProductName()%></a>
		        </div>
		        <div class="prodPrice"><%=product.getProductPrice() %></div>
		    </div>
	    <% } %>
	</div> 
</div> 
<div>
	<h2>추천 상품</h2>
</div>
<div id="main">
	<div class="slider__wrap">
	    <div class="slider__img">
	        <div class="slider__inner">
	            <div class="slider s1">
	            	<a href="<%=request.getContextPath()%>/index.jsp?group=detail&worker=detail&productNum=101">
	            		<img src="<%= request.getContextPath() %>/product_images/baby_n.jpg" alt="틴트 베이비 네일" width="350px" height="470px" />
	            	</a>
	            </div>
	            <div class="slider s2">
		            <a href="<%=request.getContextPath()%>/index.jsp?group=detail&worker=detail&productNum=100">
		            	<img src="<%= request.getContextPath() %>/product_images/basic_n.jpg" alt="베이직 네일" width="350px" height="470px" />
		            </a>
	            </div>
	            <div class="slider s3">
		            <a href="<%=request.getContextPath()%>/index.jsp?group=detail&worker=detail&productNum=94">
		           		<img src="<%= request.getContextPath() %>/product_images/creamfog_n.jpg" alt="크림 포그 네일" width="350px" height="470px" />
		            </a>
	            </div>
	            <div class="slider s4">
		            <a href="<%=request.getContextPath()%>/index.jsp?group=detail&worker=detail&productNum=96">
		            	<img src="<%= request.getContextPath() %>/product_images/audrey_n.jpg" alt="오드리 네일" width="350px" height="470px" />
		            </a>
	            </div>
	            <div class="slider s5">
		            <a href="<%=request.getContextPath()%>/index.jsp?group=detail&worker=detail&productNum=102">
		            	<img src="<%= request.getContextPath() %>/product_images/creamcheeze_n.jpg" alt="크림치즈 네일" width="350px" height="470px" />
		            </a>
	            </div>
	        </div>
		    <div class="slider__btn">
		        <a href="#" class="prev" title="왼쪽이미지">〈</a>
		        <a href="#" class="next" title="다음이미지">〉</a>
		    </div>
		    <div class="slider__dot">
		    </div>
	    </div>
	</div>
</div>

<script>
const slideWrap = document.querySelector(".sliderWrap");
const slideImg = slideWrap.querySelector(".sliderImg");         //보여지는 영역
const slideInner = slideWrap.querySelector(".sliderInner");     //움직이는 영역
const imageSlider = slideWrap.querySelectorAll(".imageSlider");              //개별 이미지

let curIndex = 0;                                               //현재 보이는 이미지
let slideCount = imageSlider.length;                                    //이미지 갯수
let slideInterval = 2000;                                          //이미지 변경 간격 시간
let slideWidth = imageSlider[0].offsetWidth;                      //이미지 가로 값
let slideClone = slideInner.firstElementChild.cloneNode(true);    //첫번째 이미지 복사

// 복사한 첫 번째 이미지 마지막에 붙여넣기
slideInner.appendChild(slideClone);

function slideEffect(){
	curIndex++;

    slideInner.style.transition = "all 0.6s";
    slideInner.style.transform = "translateX(-"+ slideWidth * curIndex +"px)";

    //마지막 이미지에 위치 했을 때
    if(curIndex == slideCount){
        setTimeout(() => {
        	slideInner.style.transition = "0s";
        	slideInner.style.transform = "translateX(0px)";
        }, 700);

        curIndex = 0;
    }

}

setInterval(slideEffect, slideInterval);


//선택자
const sliderWrap = document.querySelector(".slider__wrap");
const sliderImg = sliderWrap.querySelector(".slider__img");         //보여지는 영역
const sliderInner = sliderWrap.querySelector(".slider__inner");     //움직이는 영역
const slider = sliderWrap.querySelectorAll(".slider");              //개별 이미지
const sliderDot = sliderWrap.querySelector(".slider__dot");         //닷 메뉴
const sliderBtn = sliderWrap.querySelectorAll(".slider__btn a");    //버튼

let currentIndex = 0;                                               //현재 보이는 이미지
let sliderCount = slider.length;                                    //이미지 갯수
let sliderInterval = 2000;                                          //이미지 변경 간격 시간
let sliderWidth = slider[0].offsetWidth;                            //이미지 가로 값
let dotIndex = "";

function init(){
    //이미지 갯수만큼 닷 메뉴 생성
    slider.forEach(() => dotIndex += "<a href ='#' class='dot'>이미지</a>");
    sliderDot.innerHTML = dotIndex;

    //첫 번째 닷 메뉴한테 활성화 표시하기
    sliderDot.firstChild.classList.add("active");

}
init();


//이미지 이동시키기
function gotoSlider(num){
    sliderInner.style.transition = "all 400ms";
    sliderInner.style.transform = "translateX("+ -sliderWidth * num +"px)";
    currentIndex = num;

    //닷 메뉴 활성화하기
    let dotActive = document.querySelectorAll(".slider__dot .dot");
    dotActive.forEach((active) => active.classList.remove("active"));
    dotActive[num].classList.add("active");
}

//버튼을 클릭했을 때
sliderBtn.forEach((btn, index) => {
    btn.addEventListener("click", () => {
        let prevIndex = (currentIndex+(sliderCount-1)) % sliderCount;
        let nextIndex = (currentIndex+1) % sliderCount;   //1 2 3 4 0 1 2 3 4

        if(btn.classList.contains("prev")){
            gotoSlider(prevIndex);
        } else {
            gotoSlider(nextIndex);
        }
    });
});

$(".slider__btn").click(function(e) {
	e.preventDefault();   
});

//dot 클릭
document.querySelectorAll(".slider__dot .dot").forEach((dot, index) => {
    dot.addEventListener("click", () => {
        gotoSlider(index);
    });
});

$(".slider__dot").click(function(e) {
	e.preventDefault();   
});

</script>