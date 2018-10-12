#### spring note ####
1 Spring的属性文件读取机制
    1.1springboot
        springboot将约定大于配置的思想贯彻到底，表现在配置文件上便是，springboot在启动时会默认读取src/main/resources中的application.properties中的配置信息，无需显示的使用@PropertySource去指定扫描位置。springboot甚至会读取application-environment.propertes，如果两者含有相同的properties属性，环境属性会重写默认属性。
        对于测试环境，sb会读取src/test/resources下的配置文件。
        对于第三方库中的类也可以使用@Bean与@ConfigurationProperties注解进行属性的自动注入
    1.2springboot配置文件读取的最佳实践
        对于一个类库项目，如果配置项多，配置文件层级复杂，可以使用多个@ConfigurationProperties(prefix="prefix")注解标注的类来读取配置文件中特定的section，最后将这些Property类使用@EnableConfigurationProperties(Property.class)注解注入到类库的@Configuraion类中。属性默认的读取文件是application.properties，可以配合使用@PropertySource与@ConfigurationProperties注解来读取指定位置的配置文件。
        对于无法控制的第三方类，也可以使用@Bean @ConfigurationProperties @PropertySource注解组合，进行自动的属性注入。当然前提是，第三方类的属性有setter函数。


2 Spring类库项目的最佳实践
    2.1 配置文件
        使用@ConfigurationProperties配置一个或多个属性类，并使用@PropertySource指定特定的classpath配置文件，最好不要使用默认的application.properties。
    2.2 Spring Context
        使用一个@Configuration配置一个SpringContext，并通过@EnableConfigurationProperties注解导入2.1中定义的配置类，这样就将配置类注册到了IOC容器中，其他组件可以使用@Autowired注解注入并使用这些配置类。
    2.3 组件注册
        对于具有多个状态的组件，做好在@Configuration中使用@Bean进行注册，这样可以避免配置类在组件类中过多的使用。对于无状态的组件，可以直接使用@Component进行标注。


3 Spring实现文件下载
    3.1 直接方式
        即将文件直接放置在spring的静态资源路径中，通过一个<a href="">　指向文件，那么浏览器会自动进行文件下载。
    3.2 使用mvc相应请求
        即返回 new ResponseEntity<ByteArrayResource>(new ByteArrayResource(data),headers, HttpStatus.OK)来实现


4.Spring jpa审计功能
    @CreatedDate @CreatedBy @LastModified等字段修饰实体字段时可以在实体被创建或者更新时自动赋值。为达到这种功能需要如下设置：
    a. 实体类加上@EntityListeners(AuditingEntityListener.class)注解
    b. app启动类加上EnableAuditing注解
    c. 实现AuditorAware和DatetimeService接口以提供审计者和时间属性

5.Spring Security
    5.1Spring Filter的一般流程
        首先Filter会从HttpRequest中提取Principal和Credential组成一个AuthenticationToken，然后调用AuthenticationManger去认证该Token，而AuthenticationManager又会将认证逻辑委托给AuthenticationProvider进行处理，后者一般会从token中提取principal，并根据principal从系统资源中查询其credential信息，最后和token中的credential信息进行比对，如果两者相同则认证通过，否者失败。
6. @RequestParam @RequestBody异同
    5.1 @RequestParam
        @RequestParam除了用于primitive类型外，还可以用于POJO，假设@RequestParam(value="data")Pojo pojo，那么要求传输过来的json有如下格式：
            {
                data:{
                    
                }
            }
也就是说，只要json层级结构满足映射要求即可。甚至，可以直接去掉@RequestParam直接绑定 Pojo pojo，那么json如下：
            {
            }
就无需多一层结构。

7.跨域自定义header
    ajax在跨域请求的情况下无法读取自定义header，需要在服务器端开启这些自定义的header才能读取成功，对于spring来说，需CorsRegistry．exposedHeaders({headers})来进行设置

8.Spring @PreAuthorize
    该注解依赖于代理功能实现对方法的拦截调用,因此如果一个方法被类中的另一个方法直接调用,那么就会因为没有出发代理而导致注解失效.同时也需注意,该注解仅针对public方法有效.
    一个简单的解决方法是,在类中注入一个自身的引用,通过该引用调用方法,来触发对方法的拦截.
