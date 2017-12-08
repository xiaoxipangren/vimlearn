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
