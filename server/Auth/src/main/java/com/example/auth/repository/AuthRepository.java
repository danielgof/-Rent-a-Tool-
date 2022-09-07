package com.example.auth.repository;

import com.example.auth.models.AuthUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface AuthRepository extends JpaRepository<AuthUser, Long> {
    @Query("SELECT s FROM AuthUser s WHERE s.Id =?1")
    Optional<AuthUser> findUsersById(Long id);
}
