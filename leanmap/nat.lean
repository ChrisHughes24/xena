
-- TODO ask Mario why instance : distrib nat            := by apply_instance
-- is in lemmas.lean in core nat

import data.nat.dist -- distance function
import data.nat.gcd -- gcd
import data.nat.modeq -- modular arithmetic
import data.nat.prime -- prime number stuff 
import data.nat.sqrt  -- square roots

open nat 

example : fact 4 = 24 := rfl -- factorial 

example (a : ℕ) : fact a > 0 := fact_pos a

example : dist 6 4 = 2 := rfl -- distance function

example (a b : ℕ) : a ≠ b → dist a b > 0 := dist_pos_of_ne 

example (a b : ℕ) : gcd a b ∣ a ∧ gcd a b ∣ b := gcd_dvd a b 

example : lcm 6 4 = 12 := rfl 

example (a b : ℕ) : lcm a b = lcm b a := lcm_comm a b
example (a b : ℕ) : gcd a b * lcm a b = a * b := gcd_mul_lcm a b

example (a b : ℕ) : (∀ k : ℕ, k > 1 → k ∣ a → ¬ (k ∣ b) ) → coprime a b := coprime_of_dvd 

-- type the congruence symbol with \== 

example : 5 ≡ 8 [MOD 3] := rfl

example (a b c d m : ℕ) : a ≡ b [MOD m] → c ≡ d [MOD m] → a * c ≡ b * d [MOD m] := modeq.modeq_mul

-- nat.sqrt is integer square root (it rounds down).

#eval sqrt 1000047
-- returns 1000

example (a : ℕ) : sqrt (a * a) = a := sqrt_eq a

example (a b : ℕ) : sqrt a < b ↔ a < b * b := sqrt_lt 

-- nat.prime n returns whether n is prime or not.
-- We can prove 59 is prime if we first tell Lean that primality 
-- is decidable. But it's slow because the algorithms are
-- not optimised for the kernel.

instance : decidable (prime 59) := decidable_prime_1 59 
example : prime 59 := dec_trivial 

example (p : ℕ) : prime p → p ≥ 2 := prime.ge_two

example (p : ℕ) : prime p ↔ p ≥ 2 ∧ ∀ m, 2 ≤ m → m ≤ sqrt p → ¬ (m ∣ p) := prime_def_le_sqrt

example (p : ℕ) : prime p → (∀ m, coprime p m ∨ p ∣ m) := coprime_or_dvd_of_prime

example : ∀ n, ∃ p, p ≥ n ∧ prime p := exists_infinite_primes 

-- min_fac returns the smallest prime factor of n (or junk if it doesn't have one)

example : min_fac 12 = 2 := rfl 

-- `factors n` is the prime factorization of `n`, listed in increasing order.
-- As far as I can see this isn't decidable, and doesn't seem to reduce either.
-- But we can evaluate it in the virtual machine using #eval .

#eval factors (2^32+1)
-- [641, 6700417]
