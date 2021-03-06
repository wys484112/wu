<%@ page pageEncoding="utf-8"%>
<%--shiro 标签 --%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<% 
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
 	String test=request.getParameter("index");
 %> 
<script baseUrl="<%=basePath%>" src="<%=basePath%>/js/user.login.js"></script>
<script>
	
<%--中英文语言切换--%>	
<%--
			语言切换
			当前页面刷新，
			通过正则表达式删除多余的语言参数
			添加参数 lang=en_US 或者lang=zh_CN
			
			类似如下url
			http://localhost:8080/site.management/site/index.shtml?lang=zh_CN			
			--%>
	function js_lang_cn_method() {
		var lang_url = window.location.href
				.replace(/&*lang=(zh_CN|en_US)/g, "");
		lang_url = lang_url.replace(/\?$/g, "");
		var index = lang_url.search(/\?/g);
		<%--
		layer.msg(lang_url);
		layer.msg(index);
		--%>		
		if (index != -1) {
			window.location.href = lang_url.concat("&lang=zh_CN");
		} else {
			window.location.href = lang_url.concat("?lang=zh_CN");
		}
	}
	function js_lang_en_method() {
		var lang_url = window.location.href
				.replace(/&*lang=(zh_CN|en_US)/g, "");
		lang_url = lang_url.replace(/\?$/g, "");
		var index = lang_url.search(/\?/g);

		<%--
		layer.msg(lang_url);
		layer.msg(index);
		--%>
		if (index != -1) {
			window.location.href = lang_url.concat("&lang=en_US");
		} else {
			window.location.href = lang_url.concat("?lang=en_US");
		}
	}
</script>
<div class="navbar navbar-inverse navbar-fixed-top animated fadeInDown" style="z-index: 101;height: 41px;">
	  
      <div class="container" style="padding-left: 0px; padding-right: 0px;">
        <div class="navbar-header">
          <button data-target=".navbar-collapse" data-toggle="collapse" type="button" class="navbar-toggle collapsed">
            <span class="sr-only">导航</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
	     </div>
	     <div role="navigation" class="navbar-collapse collapse">
	     		<a id="_logo"  href="<%=basePath%>" style="color:#fff; font-size: 24px;" class="navbar-brand hidden-sm">工 地 管 理 演 示</a>
	          <ul class="nav navbar-nav" id="topMenu">
				<li class="dropdown ${param.index == 1 ? "active" : " " } ">
					<a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown" class="dropdown-toggle" href="<%=basePath%>/user/index.shtml">
						个人中心<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="<%=basePath%>/user/index.shtml">个人资料</a></li>
						<li><a href="<%=basePath%>/user/updateSelf.shtml" >资料修改</a></li>
						<li><a href="<%=basePath%>/user/updatePswd.shtml" >密码修改</a></li>
						<li><a href="<%=basePath%>/role/mypermission.shtml">我的权限</a></li>
					</ul>
				</li>	  
				<%--拥有 角色888888（管理员） ||  100002（用户中心）--%>
				<shiro:hasAnyRoles name='888888,100002'>          
				<li class="dropdown ${param.index == 2 ? "active" : " " } ">
					<a aria-expanded="false" aria-haspopup="true"  role="button" data-toggle="dropdown" class="dropdown-toggle" href="<%=basePath%>/member/list.shtml">
						用户中心<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<shiro:hasPermission name="/member/list.shtml">
							<li><a href="<%=basePath%>/member/list.shtml">用户列表</a></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="/member/online.shtml">
							<li><a href="<%=basePath%>/member/online.shtml">在线用户</a></li>
						</shiro:hasPermission>
					</ul>
				</li>	
				</shiro:hasAnyRoles>         
				<%--拥有 active888888（管理员） ||  100003（权限频道）--%>
				<shiro:hasAnyRoles name='888888,100003'>
				<li class="dropdown ${param.index == 3 ? "active" : " " } ">
						<a aria-expanded="false" aria-haspopup="true"  role="button" data-toggle="dropdown" class="dropdown-toggle" href="/permission/index.shtml">
							权限管理<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<shiro:hasPermission name="/role/index.shtml">
								<li><a href="<%=basePath%>/role/index.shtml">角色列表</a></li>
							</shiro:hasPermission>
							<shiro:hasPermission name="/role/allocation.shtml">
								<li><a href="<%=basePath%>/role/allocation.shtml">角色分配</a></li>
							</shiro:hasPermission>
							<shiro:hasPermission name="/permission/index.shtml">
								<li><a href="<%=basePath%>/permission/index.shtml">权限列表</a></li>
							</shiro:hasPermission>
							<shiro:hasPermission name="/permission/allocation.shtml">
								<li><a href="<%=basePath%>/permission/allocation.shtml">权限分配</a></li>
							</shiro:hasPermission>
						</ul>
					</li>	
				</shiro:hasAnyRoles> 
				
				
				<li class="dropdown ${param.index == 4 ? "active" : " " } ">
					<a aria-expanded="false" aria-haspopup="true"  role="button" data-toggle="dropdown" class="dropdown-toggle" href="/site/index.shtml">
						工地管理<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">					
						<shiro:hasPermission name="/site/index.shtml">
							<li><a href="<%=basePath%>/site/index.shtml">工地列表</a></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="/site/allocation.shtml">
							<li><a href="<%=basePath%>/site/allocation.shtml">工地分配</a></li>
						</shiro:hasPermission>
						
						<li><a href="<%=basePath%>/site/fileupload.shtml">工地图片上传</a></li>
						
					</ul>
				</li>	
									   			        
	          </ul>

			  <a href="javascript:void(0);" onclick="js_lang_cn_method();" style="color:#fff; font-size: 13px; padding:10px" class="pull-right"><spring:message code="language.cn" /></a>
			  <a href="javascript:void(0);" onclick="js_lang_en_method();" style="color:#fff; font-size: 13px; padding:10px 3px" class="pull-right"><spring:message code="language.en" /></a>	          
	           <ul class="nav navbar-nav  pull-right" >
				<li class="dropdown " style="color:#fff;">
					<%--已经登录（包括记住我的）--%>
					<shiro:user>  
						<a aria-expanded="false" aria-haspopup="true"  role="button" data-toggle="dropdown" onclick="location.href='<%=basePath%>/user/index.shtml'" href="<%=basePath%>/user/index.shtml" class="dropdown-toggle qqlogin" > 
						<shiro:principal property="nickname"/>
						<span class="caret"></span></a>
						<ul class="dropdown-menu" userid="<shiro:principal property="id"/>">
							<li><a href="<%=basePath%>/user/index.shtml">个人资料</a></li>
							<li><a href="<%=basePath%>/role/mypermission.shtml">我的权限</a></li>
							<li><a href="javascript:void(0);" onclick="logout();">退出登录</a></li>
						</ul>
					</shiro:user>   

					<%--没有登录(游客)--%>
					<shiro:guest>  
						 <a aria-expanded="false" aria-haspopup="true"  role="button" data-toggle="dropdown"  href="javascript:void(0);" class="dropdown-toggle qqlogin" >
						<img src="//qzonestyle.gtimg.cn/qzone/vas/opensns/res/img/Connect_logo_1.png">&nbsp;登录</a>
					</shiro:guest>  
				</li>	
	          </ul>
	          <style>#topMenu>li>a{padding:10px 13px}</style>
	    </div>
  	</div>
</div>
