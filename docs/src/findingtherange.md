# The Rational Range

----


## the rational milieu

A rational value has two integer-valued components, the numerator and the denominator. Usually, rational arithmetic is applied to two values at a time.  `muladd` is applied to three rational values.  Here are `*`, `+` and `muladd` for rationals.

```
(a/b * c/d) == (a * c) / (b * d)

(a/b + c/d) == ((a * d) + (b * c)) / (b * d)

(a/b * c/d) + s/t == ((a * c * t) + (b * d * s)) / (b * d * t)
```

Without loss of generality, assume these are values of type Rational{Int32}.  We know each numerator and each denominator hold signed integer values stored in 32 bits.  One bit of an Int32 is used to keep the sign, so there are 31 bits available to hold a magnitude.
(Of course, real Int32 quantities do not use sign+magnitude encoding; two's complement is used.  This temporary fiction simplifies.)
The maximum magnitude available is `typemax(T)`, here `typemax(Int32) == 2_147_483_647`. This value becomes more meaningful when seen in hexadecimal (0x7fffffff), and to understand that, look at the first part in binary (0x7f == 0b0111_1111).  `typemax(T)` is an initial zero bit followed entirely by one bits, whenever `T` is built-in signed integer type.

Why does it matter?  Multiplication of two of these component values will overflow unless there are enough leading zero bits available within those values.  The product of two `B` bit `Signed` system types cannot overflow when there are more than `B+1` leading zero bits between the two values being multiplied. This is a sufficient characterization, and I prefer to work with a modicum of slack. The actual implementation uses `B+2` to allow for results that obtain from adding two products, and keeping that slack.

We have quietly assumed both are nonnegative values.
(There is little benfit to pulling in all the detail that becomes resolved in the source code, it would shade the key insights).




-----

|      the series formulation         |
|:-----------------------------------:|
| ![e_series](assets/e_series.PNG)    |