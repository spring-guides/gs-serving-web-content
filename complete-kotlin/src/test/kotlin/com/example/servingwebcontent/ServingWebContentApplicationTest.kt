package com.example.servingwebcontent

import org.hamcrest.Matchers.containsString
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.webmvc.test.autoconfigure.WebMvcTest
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.get

@WebMvcTest(GreetingController::class)
class ServingWebContentApplicationTest(@Autowired private val mockMvc: MockMvc) {

    @Test
    fun homePage() {
        // N.B. jsoup can be useful for asserting HTML content
        mockMvc.get("/index.html").andExpect {
            content { string(containsString("Get your greeting")) }
        }
    }

    @Test
    fun greeting() {
        mockMvc.get("/greeting").andExpect {
            content { string(containsString("Hello, World!")) }
        }
    }

    @Test
    fun greetingWithUser() {
        mockMvc.get("/greeting") {
            param("name", "Greg")
        }.andExpect {
            content { string(containsString("Hello, Greg!")) }
        }
    }

}
