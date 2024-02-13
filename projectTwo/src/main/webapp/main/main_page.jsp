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
<style>
.prodList {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
}

.container {
	text-align: center;
}

h2 {
	margin:30px;
}
.slider__wrap {
    width: 100%;
    height: 500px;
    display: flex;
    align-items: center;
    justify-content: center;
}
.slider__img {  /* 이미지가 보이는 영역 */
    position: relative;
    width: 800px;
    height: 450px;
    overflow: hidden;
}
.slider__inner {    /* 이미지 움직이는 영역 */
    display: flex;
    flex-wrap: wrap;
    width: 4800px;  /* 총 이미지 영역 */
    height: 450px;
}
.slider {   /* 개별적인 이미지 */
    position: relative;
    width: 800px;
    height: 450px;
}
.slider__btn a {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    width: 50px;
    height: 50px;
    line-height: 50px;
    text-align: center;
    background-color: #ffffffbd;
    transition: all 0.3s ease;
}
.slider__btn a:hover {
    border-radius: 50%;
    background-color: rgb(245, 242, 67);
    color: #000;
}
.slider__btn a.prev {
    left: 0;
}
.slider__btn a.next {
    right: 0;
}
.slider__dot {
    position: absolute;
    left: 50%;
    bottom: 30px;
    transform: translateX(-50%);
}
.slider__dot .dot {
    width: 20px;
    height: 20px;
    background-color: rgba(255, 255, 255, 0.3);
    display: inline-block;
    border-radius: 50%;
    text-indent: -9999px;
    transition: all 0.3s;
    margin: 2px;
}
.slider__dot .dot.active {
    background-color: rgba(255, 255, 255, 1);
}
</style>
<div>
<img src="<%= request.getContextPath() %>/images/main_image.jpg" width="65%"height="600">
</div>
<br>
<div>
	<h2>이달의 신상품</h2>
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
	            <div class="slider s1"><img src="<%= request.getContextPath() %>/product_images/apricot_n.jpg" width="100%" height="100%" alt="이미지4"></div>
	            <div class="slider s2"><img src="<%= request.getContextPath() %>/product_images/apricot_n2.jpg" width="100%" height="100%" alt="이미지10"></div>
	            <div class="slider s3"><img src="<%= request.getContextPath() %>/product_images/apricot_n3.jpg" width="100%" height="100%" alt="이미지9"></div>
	            <div class="slider s4"><img src="<%= request.getContextPath() %>/product_images/audrey_n.jpg" width="100%" height="100%" alt="이미지7"></div>
	            <div class="slider s5"><img src="<%= request.getContextPath() %>/product_images/audrey_n2.jpg" width="100%" height="100%" alt="이미지3"></div>
	        </div>
		    <div class="slider__btn">
		        <a href="#" class="prev" title="왼쪽이미지">prev</a>
		        <a href="#" class="next" title="다음이미지">next</a>
		    </div>
		    <div class="slider__dot">
		    </div>
	    </div>
	</div>
</div>

<script>
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

</script>