<#assign project_id="gs-serving-web-content">
This guide walks you through the process of creating a "hello world" web site with Spring.

What you'll build
-----------------

You'll build a service that will accept HTTP GET requests at:

    http://localhost:8080/greeting

and respond with a web page displaying a greeting:

    "Hello, World!"

You can customize the greeting with an optional `name` parameter in the query string:

    http://localhost:8080/greeting?name=User

The `name` parameter value overrides the default value of "World" and is reflected in the response:

    "Hello, User!"


What you'll need
----------------

 - About 15 minutes
 - <@prereq_editor_jdk_buildtools/>


## <@how_to_complete_this_guide jump_ahead='Create a web controller'/>


<a name="scratch"></a>
Set up the project
------------------

<@build_system_intro/>

<@create_directory_structure_hello/>


<@create_both_builds/>

<@bootstrap_starter_pom_disclaimer/>


<a name="initial"></a>
Create a web controller
-----------------------

In Spring's approach to building web sites, HTTP requests are handled by a controller. You can easily identify these requests by the [`@Controller`] annotation. In the following example, the GreetingController handles GET requests for /greeting by returning the name of a [`View`], in this case, "greeting". A `View` is responsible for rendering the HTML content:

    <@snippet path="src/main/java/hello/GreetingController.java" prefix="complete"/>

This controller is concise and simple, but there's plenty going on. Let's break it down step by step.

The `@RequestMapping` annotation ensures that HTTP requests to `/greeting` are mapped to the `greeting()` method.

> **Note:** The above example does not specify `GET` vs. `PUT`, `POST`, and so forth, because `@RequestMapping` maps all HTTP operations by default. Use `@RequestMapping(method=GET)` to narrow this mapping.

[`@RequestParam`] binds the value of the query String parameter `name` into the `name` parameter of the `greeting()` method. This query String parameter is not `required`; if it is absent in the request, the `defaultValue` of "World" is used. The value of the `name` parameter is added to a [`Model`] object, ultimately making it accessible to the view template.

The implementation of the method body relies on a [view technology][u-view-templates], in this case [Thymeleaf](http://www.thymeleaf.org/doc/html/Thymeleaf-Spring3.html), to perform server-side rendering of the HTML. Thymeleaf parses the `greeting.html` template below and evaluates the `th:text` expression to render the value of the <#noparse>`${name}`</#noparse> parameter that was set in the controller.

    <@snippet path="src/main/resources/templates/greeting.html" prefix="complete"/>


Make the application executable
-------------------------------

Although it is possible to package this service as a traditional [WAR][u-war] file for deployment to an external application server, the simpler approach demonstrated below creates a standalone application. You package everything in a single, executable JAR file, driven by a good old Java `main()` method. Along the way, you use Spring's support for embedding the [Tomcat][u-tomcat] servlet container as the HTTP runtime, instead of deploying to an external instance.

### Create an Application class

    <@snippet path="src/main/java/hello/Application.java" prefix="complete"/>

The `main()` method defers to the [`SpringApplication`][] helper class, providing `Application.class` as an argument to its `run()` method. This tells Spring to read the annotation metadata from `Application` and to manage it as a component in the [Spring application context][u-application-context].

The [`@ComponentScan`][] annotation tells Spring to search recursively through the `hello` package and its children for classes marked directly or indirectly with Spring's [`@Component`][] annotation. This directive ensures that Spring finds and registers the `GreetingController`, because it is marked with [`@Controller`][], which in turn is a kind of [`@Component`][] annotation.

The [`@EnableAutoConfiguration`][] annotation switches on reasonable default behaviors based on the content of your classpath. For example, because the application depends on the embeddable version of Tomcat (tomcat-embed-core.jar), a Tomcat server is set up and configured with reasonable defaults on your behalf. And because the application also depends on Spring MVC (spring-webmvc.jar), a Spring MVC [`DispatcherServlet`][] is configured and registered for you — no `web.xml` necessary! Auto-configuration is a powerful, flexible mechanism. See the [API documentation][`@EnableAutoConfiguration`] for further details.

<@build_an_executable_jar_subhead/>

<@build_an_executable_jar_with_both/>

<@run_the_application_with_both module="service"/>

Logging output is displayed. The service should be up and running within a few seconds.


Test the service
----------------

Now that the web site is running, visit [http://localhost:8080/greeting](http://localhost:8080/greeting), where you see:

    "Hello, World!"

Provide a `name` query string parameter with [http://localhost:8080/greeting?name=User](http://localhost:8080/greeting?name=User). Notice how the message changes from "Hello, World!" to "Hello, User!":

    "Hello, User!"

This change demonstrates that the [`@RequestParam`] arrangement in `GreetingController` is working as expected. The `name` parameter has been given a default value of "World", but can always be explicitly overridden through the query string.


Summary
-------

Congratulations! You have just developed a web page using Spring.


<@u_war/>
<@u_tomcat/>
<@u_application_context/>
<@u_view_templates/>
[`View`]: http://static.springsource.org/spring/docs/current/javadoc-api/org/springframework/web/servlet/View.html
[`Model`]: http://static.springsource.org/spring/docs/current/javadoc-api/org/springframework/ui/Model.html
[`@Configuration`]:http://static.springsource.org/spring/docs/current/javadoc-api/org/springframework/context/annotation/Configuration.html
[`@ComponentScan`]: http://static.springsource.org/spring/docs/current/javadoc-api/org/springframework/context/annotation/ComponentScan.html
[`@Component`]: http://static.springsource.org/spring/docs/current/javadoc-api/org/springframework/stereotype/Component.html
[`@Controller`]: http://static.springsource.org/spring/docs/current/javadoc-api/org/springframework/stereotype/Controller.html
[`@ResponseBody`]:http://static.springsource.org/spring/docs/current/javadoc-api/org/springframework/web/bind/annotation/ResponseBody.html
[`@RequestParam`]:http://static.springsource.org/spring/docs/current/javadoc-api/org/springframework/web/bind/annotation/ResponseBody.html
[`SpringApplication`]: http://docs.spring.io/spring-boot/docs/0.5.0.M3/api/org/springframework/boot/SpringApplication.html
[`DispatcherServlet`]: http://static.springsource.org/spring/docs/current/javadoc-api/org/springframework/web/servlet/DispatcherServlet.html
[`@EnableAutoConfiguration`]: http://docs.spring.io/spring-boot/docs/0.5.0.M3/api/org/springframework/boot/autoconfigure/EnableAutoConfiguration.html
