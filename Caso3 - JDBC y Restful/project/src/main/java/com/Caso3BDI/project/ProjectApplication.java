package com.Caso3BDI.project;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = { "com.Caso3BDI.project.controller", "com.Caso3BDI.project.dao", "com.Caso3BDI.project.model"})
public class ProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(ProjectApplication.class, args);
	}

}

