# Using the BBP formula
#
# The Bailey–Borwein–Plouffe formula (BBP formula) is a formula for π

using FastRationals
using BenchmarkTools

const BT=BenchmarkTools.DEFAULT_PARAMETERS;
BT.overhead=BenchmarkTools.estimate_overhead();
BT.evals=1; ; BT.time_tolerance = 5.0e-7; BT.samples = 15;

const big1 = BigInt(1)
const big2 = BigInt(2)
const big4 = BigInt(4)
const big5 = BigInt(5)
const big6 = BigInt(6)
const big8 = BigInt(8)
const big16 = BigInt(16)

function bpp(::Type{T}, n) where {T}
    result = zero(T)
    for k = 0:n
       eightk = big8 * k
       cur = T(big4,eightk+1) -
             T(big2,eightk+4) -
             T(big1,eightk+5) -
             T(big1,eightk+6)
       cur = T(big1, big16^k) * cur
       result = result + cur
    end
    return result
end

#=
Computing Bailey–Borwein–Plouffe formula for Pi
to ascertain the performance of FastRational{BigInt}
relative to Rational{BigInt} by BPP iterations
=#

# err ~1e-54, 1_328 digits in num, den
systemqtime = @belapsed bpp(Rational{BigInt},   15);
fastqtime = @belapsed bpp(FastRational{BigInt}, 15);
bpp15 = round(fasttime/systemqqtime, digits=1)

# err ~1e368, 57_914 digits in num, den
systemqtime = @belapsed bpp(Rational{BigInt},   125);
fastqtime = @belapsed bpp(FastRational{BigInt}, 125);
bpp125 = round(fastqtime/systemqqtime, digits=1)

# relspeeds meet at n=328

# err ~1e368, 57_914 digits in num, den
systemqtime = @belapsed bpp(Rational{BigInt},   250);
fastqtime = @belapsed bpp(FastRational{BigInt}, 250);
bpp250 = round(fastqtime/systemqtime, digits=1)

systemqtime = @belapsed bpp(Rational{BigInt},   500);
fastqtime = @belapsed bpp(FastRational{BigInt}, 500);
bpp500 = round(fastqtime/systemqtime, digits=1)

systemqtime = @belapsed bpp(Rational{BigInt},   1000);
fastqtime = @belapsed bpp(FastRational{BigInt}, 1000);
bpp1000 = round(fastqtime/systemqtime, digits=1)

systemqtime = @belapsed bpp(Rational{BigInt},   2000);
fastqtime = @belapsed bpp(FastRational{BigInt}, 2000);
bpp2000 = round(fastqtime/systemqtime, digits=1)

systemqtime = @belapsed bpp(Rational{BigInt},   3000);
fastqtime = @belapsed bpp(FastRational{BigInt}, 3000);
bpp3000 = round(fastqtime/systemqtime, digits=1)



relspeeds = (bpp15=bpp15, bpp125=bpp125, bpp250=bpp250, 
             bpp500=bpp500, bpp1000=bpp1000, bpp2000=bpp2000,
             bpp5000=bpp5000)

