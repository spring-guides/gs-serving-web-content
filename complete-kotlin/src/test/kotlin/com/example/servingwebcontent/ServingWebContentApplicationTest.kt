package com.example.servingwebcontent

import org.hamcrest.Matchers.containsString
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc
import org.springframework.boot.webmvc.test.autoconfigure.WebMvcTest
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.content

@WebMvcTest(controllers = [GreetingController::class])
@AutoConfigureMockMvc
class ServingWebContentApplicationTest {

	@Autowired
	private lateinit var mockMvc: MockMvc

	@Test
	@Throws(Exception::class)
	fun homePage() {
		// N.B. jsoup can be useful for asserting HTML content
		mockMvc.perform(get("/index.html"))
			.andExpect(content().string(containsString("Get your greeting")))
	}

	@Test
	@Throws(Exception::class)
	fun greeting() {
		mockMvc.perform(get("/greeting"))
			.andExpect(content().string(containsString("Hello, World!")))
	}

	@Test
	@Throws(Exception::class)
	fun greetingWithUser() {
		mockMvc.perform(get("/greeting").param("name", "Greg"))
			.andExpect(content().string(containsString("Hello, Greg!")))
	}

}
