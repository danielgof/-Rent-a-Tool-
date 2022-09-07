package com.example.auth.controller;

import com.example.auth.models.AuthUser;
import com.example.auth.service.AuthService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @GetMapping
    public String index(@RequestParam(defaultValue = "Jack") String name) {
        return String.format("Hello, %s", name);
    }

    @PostMapping
    public ResponseEntity registerUser(AuthUser authUser) {
        if (!authService.AddUser(authUser)) return new ResponseEntity(HttpStatus.BAD_REQUEST);
        else return new ResponseEntity(HttpStatus.CREATED);
    }
}
