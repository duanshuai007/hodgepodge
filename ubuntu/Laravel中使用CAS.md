
##在Laravel中使用CAS 记录 

- `laravel`使用手册:`https://laravel.com/docs/5.0/controllers `

### 一、下载代码  

切换到目录`/var/www/html/`下
`git clone http://gitlab.frogshealth.com/wmtodolist/wmtodolist.git `

切换分支
`git checkout wmtodolist_laravel_cas`

解压vendor文件

```
cd /var/www/html/wmtodolist/
unzip vendor_200415.zip
```

更改用户组和用户权限
`sudo chown -R www-data:www-data /var/www/html/wmtodolist/`
`sudo chmod -R 755 /var/www/html/wmtodolist/`

### 二、修改配置文件`.env`

首先需要在`wmtodolist`目录下执行`cp .env.example .env`,然后修改.env文件。

```
修改文件中对应的属性，以下内容为需要修改或新加的内容，原有的内容不需要删除。

REDIS_HOST=127.0.0.1        //修改redis服务器地址
REDIS_PASSWORD=null
REDIS_PORT=6379

DB_CONNECTION=mysql
DB_HOST=127.0.0.1               //数据库所在的服务器地址
DB_DATABASE=wmtodolist          //你的数据库名字
DB_USERNAME=todo                //你的数据库用户名
DB_PASSWORD=kbevHotqr6VtA       //你的数据库密码

//cas服务器地址
CAS_HOSTNAME=castest.weixinxk.net
CAS_REAL_HOSTS=castest.weixinxk.net

//cas服务器登出地址
CAS_LOGOUT_URL=https://castest.weixinxk.net/cas/logout

//cas客户端登出后的跳转地址
CAS_LOGOUT_REDIRECT=http://mytodo.com:90

//cas客户端登陆成功后的跳转地址
CAS_REDIRECT_PATH=http://mytodo.com:90/cas/login-verity

URL=http://mytodo.com:90    //laravel的访问地址
```

### 三、

```
在你的laravel项目服务器上执行以下命令
php artisan key:generate
php artisan queue:restart 
php artisan queue:work --daemon &
```


### 四、修改apache2服务器的配置文件

```
修改/etc/apache2/ports.conf
Listen 91
将端口改为我们所使用的端口号

修改/etc/apache2/sites-available/laravel.conf 

<VirtualHost *:91>                                  //端口需要修改成你开通的端口
  ServerAdmin admin@mytodo.com                      //在浏览器通过该地址访问你的laravel
     DocumentRoot /var/www/html/wmtodolist/public   //设置为你的项目文件地址
     ServerName mytodo.com                          //在浏览器通过该地址访问你的laravel

     <Directory /var/www/html/wmtodolist/public>    //设置为你的项目文件地址
        Options +FollowSymlinks
        AllowOverride All
        Require all granted
     </Directory>

     ErrorLog ${APACHE_LOG_DIR}/error.log
     CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

修改完之后需要重新启动apache服务器
sudo service apache2 restart
执行成功会输出成功的信息。
```


### 五、MySQL数据库
laravel项目中需要使用到MySQL数据库，需要创建数据库，添加用户等操作。

```
以下操作中的数据库名根据需要改成自己的数据库名和用户名

创建数据库: 
CREATE DATABASE [your database name] CHARACTER SET utf8mb4;

添加用户和密码:用户:todo 密码:kbevHotqr6VtA 可以随意修改。
CREATE USER 'todo'@'localhost' IDENTIFIED BY 'kbevHotqr6VtA';

设置用户权限:用户:todo，数据库:wmtodolist
GRANT ALL PRIVILEGES ON wmtodolist.* TO 'todo'@'localhost';

导入数据库文件:用户名:todo 数据库: wmtodolist 数据库文件:database3.sql
mysql -u todo -p wmtodolist < database3.sql
```

### 六、laravel多站点不共用同一sission的解决方法

```
这里以wmtodolist项目为例子，
修改wmtodolist/config/session.php文件中的
'cookie' => 'laravel_session' 为 'cookie' => '自定义的名字' 这个名字需要与其他项目的名字区分开
```

apache2配置多站点:

```
修改修改/etc/apache2/sites-available/laravel.conf文件，
新增站点配置后,sudo service apache2 restart 即可。
可以通过 apachectl -t来检查配置文件是否写的正确。

这里以配置两个站点作为例子，两个站点的域名分别是mytodo.com 和 mytodoplus.com,
对应的项目目录分别是/var/www/html/wmtodolist和/var/www/html/testtodolist。
 
 <VirtualHost *:90>   
  ServerAdmin admin@mytodo.com
     DocumentRoot /var/www/html/wmtodolist/public
     ServerName mytodo.com

     <Directory /var/www/html/wmtodolist/public>
        Options +FollowSymlinks
        AllowOverride All 
        Require all granted
     </Directory>

     ErrorLog ${APACHE_LOG_DIR}/error.log
     CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

<VirtualHost *:90>
  ServerAdmin admin@mytodoplus.com
     DocumentRoot /var/www/html/testtodolist/public
     ServerName mytodoplus.com

     <Directory /var/www/html/testtodolist/public>
        Options +FollowSymlinks
        AllowOverride All 
        Require all granted
     </Directory>

     ErrorLog ${APACHE_LOG_DIR}/error.log
     CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost> 
```


### 七、在todo中使用cas的记录

- 1.
	修改原登陆界面文件`resources/views/logon.blade.php`,在原登陆按钮下添加一个新的按钮
	
	```
	<div>
 		<button class="btn btn-large btn-inverse login" type="submit" value="button_cas">CAS</button>
 	</div>
	```
	
	修改原按钮的代码，增加新的属性。
	
	```
	<button class="btn btn-large btn-inverse login" type="submit" value="button_login">登入</button>
	```
	
	为了区别不同的按钮动作，修改了原来的判断按钮按下后的程序代码，修改后的代码为:
	
	```
	<script>
  $(document).ready(function(){
    // 修改标题
    document.title = '登入 | VRDUDE(we are dude)-todo';
    $('button').click(function() {
        if ($(this).val() == "button_login") {
            F.utils.$post('/user/logon.json', $('form').serialize()).then(function(res) {
            if (res.ok) {
                res.json().then(function(json) {
                    if (json.code === 1) {
                        location.href = "/index";
                    } else {
                        $('#formNotice').find('span').html('错误的Email地址或者密码，请重试').fadeOut(1000);
                    }
                });
            }
            });
        }
        else if ($(this).val() == "button_cas") {
            //$('#formNotice').find('span').html('press button cas');
            location.href='/cas/login'
        }
        return false;
    })
});
</script>
	```
- 2.
	第一步修改完成后，这是在登陆界面就会出现一个名称是cas的按钮，点击按钮后会跳转`'/cas/login'`链接。  
	在第二步中我们修改`app/Http/routes.php`文件，添加新的路由信息。
	
	```
	//cas 用户登录接口
	Route::get('/cas/login', 'CasController@login');
	//cas登陆成功或失败后页面，用来验证用户是否存在或退出已登陆的cas
	Route::get('/cas/login-verity', function () {
	    return view('login-verity');
	});
	
	添加了两个路由信息，分别对应登陆和登陆后的验证，登陆后的验证用来验证用户是否具有对应的权限。
	当检测到'/cas/login'时，就会去执行CasController.php中的login函数。
	当检测到'/cas/login-verity'时，就跳转到login-verity页面进行验证工作。
	```
- 3.
	通过执行命令`php artisan make:controller CasController`会在目录`app/Http/Controller/`目录下生成CasController.php文件，删除其中的内容，添加新内容。
	
	```
	class CasController extends Controller
	{
	    public function login() {
	        if(!cas()->checkAuthentication()) {   
	            cas()->authenticate();
	        }   
	    }   
	}
	
	当检测到路由信息'/cas/login'时就会执行login函数，首先检查是否已经验证，如果没验证则进行严重工作，验证工作由subfission/cas代码进行完成，不需要我们进行修改。
	```
- 4.
	当用户验证成功登陆CAS之后，还需要对用户的权限进行验证，也就是验证该用户是否具有登陆权限，这部分工作在`login-verity`中进行。  
	当检测到路由信息`'/cas/login-verity'`时，会跳转到页面`login-verity`.  
	该页面代码位于`resources/views/login-verity.blade.php`中。  
	具体内容如下:
	
	```
	<?php
	
	use Illuminate\Database\QueryException;
	use Illuminate\Http\Request;
	use Illuminate\Support\Fluent;
	use Illuminate\Support\Facades\Storage;
	use Illuminate\Support\Facades\File;
	
	use App\Models\User;
	use App\Enum\UserStatusEnum;
	use App\Http\Controllers\UserController;
	use App\Jobs\UpdateOnlineInfo;
	
	
	// Enable debugging
	//phpCAS::setDebug();
	// Enable verbose error messages. Disable in production!
	//phpCAS::setVerbose(true);
	
	//phpCAS::traceBegin();
	
	//获取客户退出标志
	$isexit=session()->get('isexit');
	//获取cas退出标志
	$casexit=session()->get('casclientisexit');
	
	if ($isexit == "true" and $casexit != "true") {
	    //如果退出标志置位，并且不是CAS登陆，则直接跳转到index页面
	    session()->put(['isexit' => "false"]);
	    session()->save();
	    $isLogin = 2;
	} else {
	    // Initialize phpCAS
	    $cashostname=config('cas.cas_hostname');
	    $casport=config('cas.cas_port');
	    $casuri=config('cas.cas_uri');
	    phpCAS::client(CAS_VERSION_2_0, $cashostname, $casport, $casuri);
	
	    // For production use set the CA certificate that is the issuer of the cert
	    // on the CAS server and uncomment the line below
	    #phpCAS::setCasServerCACert($cas_server_ca_cert_path);
	
	    // For quick testing you can disable SSL validation of the CAS server.
	    // THIS SETTING IS NOT RECOMMENDED FOR PRODUCTION.
	    // VALIDATING THE CAS SERVER IS CRUCIAL TO THE SECURITY OF THE CAS PROTOCOL!
	    phpCAS::setNoCasServerValidation();
	
 
		 // force CAS authentication
	    phpCAS::forceAuthentication();
	
	    if (phpCAS::hasAttributes()) {
	        $oldemail = phpCAS::getAttribute('email');
	        $email = phpCAS::getAttribute('email');
	        $username = phpCAS::getAttribute('username');
	    }   
	        
	    if ($casexit == "true") {
	        //当用户退出时会设置session中的loginbycas 和 casclientisexit 并执行phpCAS::logout(); 
	        session()->put(['isexit' => "false"]);
	        session()->put(['casclientisexit' => "false"]);
	        session()->save();
	        phpCAS::logout();
	    }   
	
	    $user = User::where(['email' => $email, 'status' => UserStatusEnum::NORMAL])->first();
	    if (! is_null($user)) {
	        $user->salt = "**";
	        $user->password="**";
	        session()->put(['user' => $user]);
	        session()->put(['loginbycas' => "yes"]);
	        (new UserController())->mydispatch(new UpdateOnlineInfo($user->id, $_SERVER["REMOTE_ADDR"], session_id()));
	        $isLogin = 1;
	    } else {
	        $isLogin = 0;
	        session()->put(['casclientisexit' => "true"]);
	        session()->save();
	    }   
	}
	
	/*
	    <p><a href="?logout=">Logout</a></p>
	    <p><a href="/cas/login-verity">确认退出</a></p>
	 */
	?>
	<html>
	    <head>
	    <title>- Todo CAS Verity -</title>
	    </head>
	    <body>
	    <div id="showstatus"></div>
	    
	    </body>
	    <script type="text/javascript">
	        window.onload=function() {
	            var islogin=<?php echo $isLogin;?>;
	            if (islogin == 1) {
	                //alert("yes");
	                document.getElementById('showstatus').innerHTML="<b>CAS认证成功，3秒后跳转到Todo首页!</b>";
	                setTimeout(function() {
	                    location.href = "/index";
	                }, 3000);
	            } else if (islogin == 2) {
	                //用户普通方式登陆，直接回到登陆界面。
	                location.href = "/index";
	            } else {
	                //alert("no");
	                document.getElementById('showstatus').innerHTML="<b>CAS认证失败,用户可能不存在或没有相应权限! 3秒后自动退出已登陆CAS账号.</b>";
	                setTimeout(function() {
	                    location.href = "/cas/login-verity";
	                }, 3000);
	            }
	        }
	    </script>
	</html>
	

	```
- 5.
	经过以上的操作，就能够成功的通过cas进行登陆了。  
	最后再修改一下退出的相关代码。  
	为了在退出时区分cas登陆和普通登陆，我在session中加入了几个标志信息。  
	首先修改UserController@logon代码，在通过普通方式成功登陆后设置
	
	```
	$request->session()->put('loginbycas', "no");
	```
	
	修改UserController@logout代码，在退出时执行。添加在程序最后。
	
	```
	//更新客户退出标志
	...
	$online->update();
	$request->session()->put(['isexit' => "true"]);
	$flag = $request->session()->get("loginbycas");
	if ($flag == "yes") {
	//如果是cas登陆的客户，需要通过cas退出
		$request->session()->put(['loginbycas' => "no"]);
		$request->session()->put(['casclientisexit' => "true"]);
	}    
	$request->session()->save();
	```
	
	修改`public/assets/js/header.js`中的`$('#header-logout').click(function() {`  
	现在退出操作都跳转到`login-verity`中执行。
	
	```
	$('#header-logout').click(function() {
	
	    F.utils.$get('/user/logout.json').then(function(res) {
	        if (res.ok) {
	            res.json().then(function(msg) {
	                if (msg.code == 1) {
	                    location.href="/cas/login-verity";
	                } else if(msg.code == 1008) {
	                    alert(msg.msg);
	                }   
	            })  
	        }   
	    })  
	})	
	```
	
### 八、

- 在调试完成后关闭`config/cas.php`中的调试开关。