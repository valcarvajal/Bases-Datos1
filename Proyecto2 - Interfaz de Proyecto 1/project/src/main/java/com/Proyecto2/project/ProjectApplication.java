package com.Proyecto2.project;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = {"com.Proyecto2.project.model", "com.Proyecto2.project.controller", "com.Proyecto2.project.dao", "com.Proyecto2.project.service"})
public class ProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(ProjectApplication.class, args);
	}

}

