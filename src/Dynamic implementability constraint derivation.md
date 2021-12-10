---
title: Dynamic Implementability Constraint Derivation
---

### Dynamic Stochastic Implementability Constraint Derivation

#### Household Problem
Budget constraint:
$$ c(s^t) + b(s^t) = (1-\tau(s^t)) \omega(s^t) l(s^t) + R(s^t) b(s^{t-1}) $$

Lagrangian:
$$
  \max_{c, l, b} \sum_{t=0}^{\infty} \sum_{s^t}
  \beta^t \pi(s^t) u(c(s^t), l(s^t)) +
  \lambda(s^t) \left[
    (1-\tau(s^t)) \omega(s^t) l(s^t) + R(s^t) b(s^{t-1}) - c(s^t) - b(s^t)
  \right] $$

FOC's:
$$\begin{align}
  c(s^t):& ~~ \lambda(s^t) = \beta^t \pi(s^t) u_c(s^t)  \\
  l(s^t):& ~~ \lambda(s^t) = \frac{- \beta^t \pi(s^t) u_l(s^t)}{(1-\tau(s^t)) \omega(s^t)}  \\
  b(s^t):& ~~ \lambda(s^t) = \sum_{s^{t+1}|s^t} \lambda(s^{t+1}) R(s^{t+1})\\
\end{align}$$

#### Implementability constraint
Housheold budget constraint:
$$ c(s^t) - (1-\tau(s^t)) \omega(s^t) l(s^t) b(s^t)  = R(s^t) b(s^{t-1}) $$

Multiply houshold budget constraint by $\lambda$:

$$
  \lambda(s^t) c(s^t) -
  \lambda(s^t) (1-\tau(s^t)) \omega(s^t) l(s^t) +
  \lambda(s^t) b(s^t) =
  \lambda(s^t) R(s^t) b(s^{t-1})
$$
$$
  \beta^t \pi(s^t) u_c(s^t) c(s^t) -
  \frac{- \beta^t \pi(s^t) u_l(s^t)}{(1-\tau(s^t)) \omega(s^t)} (1-\tau(s^t)) \omega(s^t) l(s^t) +
  \sum_{s^{t+1}|s^t} \lambda(s^{t+1}) R(s^{t+1}) b(s^t) =
  \lambda(s^t) R(s^t) b(s^{t-1}) \\
$$
$$
  \beta^t \pi(s^t) u_c(s^t) c(s^t) +
  \beta^t \pi(s^t) u_l(s^t) l(s^t) +
  \sum_{s^{t+1}|s^t} \lambda(s^{t+1}) R(s^{t+1}) b(s^t) =
  \lambda(s^t) R(s^t) b(s^{t-1})
$$

$$
  \beta^t \pi(s^t) \left[ u_c(s^t) c(s^t) + u_l(s^t) l(s^t) \right] +
  \sum_{s^{t+1}|s^t} \lambda(s^{t+1}) R(s^{t+1}) b(s^t) =
  \lambda(s^t) R(s^t) b(s^{t-1})
$$

$$ ... \forall s^t, t $$

s^0:
$$
\beta^0 \pi(s^0) \left[ u_c(s^0) c(s^0) + u_l(s^0) l(s^0) \right] +
\sum_{s^{1}|s^0} \lambda(s^{1}) R(s^{1}) b(s^0) =
\lambda(s^0) R(s^0) b(s^{-1})
$$

(One specific) s^1:
$$
\beta^1 \pi(s^1) \left[ u_c(s^1) c(s^1) + u_l(s^1) l(s^1) \right] +
\sum_{s^{2}|s^1} \lambda(s^{2}) R(s^{2}) b(s^1) =
\lambda(s^1) R(s^1) b(s^{0})
$$

Note that this equation holds for all $s^1$ (every possible state at $t=1$), so we can sum over all $s^1$ to get:
$$
\sum_{s^1|s^0} \beta^1 \pi(s^1) \left[ u_c(s^1) c(s^1) + u_l(s^1) l(s^1) \right] +
\sum_{s^1|s^0} \sum_{s^{2}|s^1} \lambda(s^{2}) R(s^{2}) b(s^1) =
\sum_{s^1|s^0} \lambda(s^1) R(s^1) b(s^{0})
$$

$$
\sum_{s^1|s^0} \beta^1 \pi(s^1) \left[ u_c(s^1) c(s^1) + u_l(s^1) l(s^1) \right] +
\sum_{s^2|s^0} \lambda(s^{2}) R(s^{2}) b(s^1) =
\sum_{s^1|s^0} \lambda(s^1) R(s^1) b(s^{0})
$$

<!-- s^2:
$$
\beta^2 \pi(s^2) \left[ u_c(s^2) c(s^2) + u_l(s^2) l(s^2) \right] +
\sum_{s^{3}|s^2} \lambda(s^{3}) R(s^{3}) b(s^2) =
\lambda(s^2) R(s^2) b(s^{1})
$$ -->

Sum over all $t$, noticing that the last term on the LHS cancels with the RHS term for each $s^t$, $s^{t+1}$ pair:

$$
  \sum_{t=0}^{\infty} \sum_{s^t} \beta^t \pi(s^t) \left[ u_c(s^t) c(s^t) + u_l(s^t) l(s^t) \right] +
  \lim_{T \rightarrow \infty}
    \sum_{s^{T}} \lambda(s^{T}) R(s^{T}) b(s^T) =
  \beta^0 \pi(s^0) u_c(s^0) R(s^0) b(s^{-1})
$$

The limit term is the transversality condition and therefore is zero, so can simplify:

$$
  \sum_{t=0}^{\infty} \sum_{s^t} \beta^t \pi(s^t) \left[ u_c(s^t) c(s^t) + u_l(s^t) l(s^t) \right] =
  u_c(s^0) R(s^0) b(s^{-1})
$$

#### State-congtingent bonds equation

To get b(s^t), we can follow the same procedure as above, but starting at time $t$ instead of time 0. This will give a sort of "time $t$ version" of the implementability constraint:

$$
  \sum_{r=t}^{\infty} \sum_{s^r} \beta^r \pi(s^r) \left[ u_c(s^r) c(s^r) + u_l(s^r) l(s^r) \right] =
  \beta^t \pi(s^t) u_c(s^t) R(s^t) b(s^{t-1})
$$

Pull the time $t$ term out of the summation:

$$
  \beta^t \pi(s^t) \left[ u_c(s^t) c(s^t) + u_l(s^t) l(s^t) \right] +
  \sum_{r=t+1}^{\infty} \sum_{s^r} \beta^r \pi(s^r) \left[ u_c(s^r) c(s^r) + u_l(s^r) l(s^r) \right] =
  \beta^t \pi(s^t) u_c(s^t) R(s^t) b(s^{t-1})
$$

Rearrange and simplify:
$$
  \sum_{r=t+1}^{\infty} \sum_{s^r} \beta^r \pi(s^r) \left[ u_c(s^r) c(s^r) + u_l(s^r) l(s^r) \right] =
  \beta^t \pi(s^t) u_c(s^t) R(s^t) b(s^{t-1}) - \beta^t \pi(s^t) \left[ u_c(s^t) c(s^t) + u_l(s^t) l(s^t) \right]
$$

$$
  \sum_{r=t+1}^{\infty} \sum_{s^r} \beta^r \pi(s^r) \left[ u_c(s^r) c(s^r) + u_l(s^r) l(s^r) \right] =
  \beta^t \pi(s^t) \left[
    u_c(s^t) R(s^t) b(s^{t-1}) - u_c(s^t) c(s^t) - u_l(s^t) l(s^t) \right]
$$

Substitute for $u_l(s^t)$ using the household FOC:
$$
  \sum_{r=t+1}^{\infty} \sum_{s^r} \beta^r \pi(s^r) \left[ u_c(s^r) c(s^r) + u_l(s^r) l(s^r) \right] =
  \beta^t \pi(s^t) \left[
    u_c(s^t) R(s^t) b(s^{t-1}) - u_c(s^t) c(s^t) + u_c(s^t) (1-\tau(s^t)) \omega(s^t) l(s^t) \right]
$$

$$
  \sum_{r=t+1}^{\infty} \sum_{s^r} \beta^r \pi(s^r) \left[ u_c(s^r) c(s^r) + u_l(s^r) l(s^r) \right] =
  \beta^t \pi(s^t) u_c(s^t) \left[
    R(s^t) b(s^{t-1}) - c(s^t) + (1-\tau(s^t)) \omega(s^t) l(s^t)
  \right]
$$

$$
  \sum_{r=t+1}^{\infty} \sum_{s^r} \beta^r \pi(s^r) \left[ u_c(s^r) c(s^r) + u_l(s^r) l(s^r) \right] =
  \beta^t \pi(s^t) u_c(s^t) b(s^t)
$$

$$
  b(s^t) = \sum_{r=t+1}^{\infty} \sum_{s^r} \beta^{r-t} \pi(s^r|s^t) \left[ u_c(s^r) c(s^r) + u_l(s^r) l(s^r) \right] / u_c(s^t)
$$
