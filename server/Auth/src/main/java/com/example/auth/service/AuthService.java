package com.example.auth.service;

import com.example.auth.models.AuthUser;
import com.example.auth.repository.AuthRepository;
import org.springframework.stereotype.Service;
import com.example.auth.models.AuthUser;

import java.util.Optional;

@Service
public class AuthService {

    private final AuthRepository authRepository;

    public AuthService(AuthRepository AuthRepository) {
        this.authRepository = AuthRepository;
    }

    public boolean AddUser(AuthUser authUser) {
        Optional<AuthUser> AuthOptional = authRepository.findUsersById(authUser.getId());
        if (AuthOptional.isPresent()) {
            throw new IllegalStateException("email taken");
        }
        else authRepository.save(authUser);
        return true;
    }
}
