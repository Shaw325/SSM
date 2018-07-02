# SSM
SSM整合员工管理系统
查询-Ajax
	1.index.jsp页面直接发送ajax请求进行员工分页数据的查询
	2.服务器将查出的数据，以json字符串的形式返回给浏览器
	3.浏览器收到js字符串。可以使用js对json进行解析，
	      使用js通过dom增删改改变页面
	4.返回json，实现客户端的无关性	
	5.利用JSR303进行后端效验，保证数据的安全性
  
  功能点：
    1.分页
    2.数据效验
      a.jquery前端效验+JSR303后端效验
    3.Ajax
    4.Rest风格的URL：使用HTTP协议请求方式的动词，来表示对资源的操作
    GET（查询）、POST（新增）、PUT（修改）、DELETE（删除）

技术点：
    1.基础框架SSM（SpringMVC+Spring+Mybatis）
    2.数据库-MySQL
    3.前端框架-bootstrap快速搭建简洁美观的界面
    4.项目的依赖管理-Maven
    5.分页-pageHelper
    6.逆向工程-MyBatis Generator
![Alt text](https://github.com/Shaw325/SSM/raw/master/img/1.png)
![Alt text](https://github.com/Shaw325/SSM/raw/master/img/2.png)
![Alt text](https://github.com/Shaw325/SSM/raw/master/img/3.png)
![Alt text](https://github.com/Shaw325/SSM/raw/master/img/4.png)
