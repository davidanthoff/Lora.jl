##########################################################################################
#
#    Log likelihood accumulator : type definition and derivation rules
#
##########################################################################################

# this makes the model function easier to generate compared to a Float64
#   - embeds the error throwing when log-likelihood reaches -Inf
#   - calculates the sum when logpdf() returns an Array
type OutOfSupportError <: Exception ; end

immutable LLAcc
	val::Float64
	function LLAcc(x::Real)
		isfinite(x) || throw(OutOfSupportError())
		new(x)
	end
end
+(ll::LLAcc, x::Real)           = LLAcc(ll.val + x)
+(ll::LLAcc, x::Array{Float64}) = LLAcc(ll.val + sum(x))

# ReverseDiffSource.@typeequiv MCMC.LLAcc 1 # declares new type to Autodiff
ReverseDiffSource.@typeequiv2 LLAcc 1 # declares new type to Autodiff

####### derivation rules  ############
# (note : only additions are possible with LLAcc type )
# ReverseDiffSource.@deriv_rule getfield(x::LLAcc, f )  x  dx1 = ds
ReverseDiffSource.@deriv_rule LLAcc(x::Real) x  ds[1]

ReverseDiffSource.@deriv_rule   +(x::LLAcc,   y)                  x   ds
ReverseDiffSource.@deriv_rule   +(x::LLAcc,   y::Real)            y   ds[1]
ReverseDiffSource.@deriv_rule   +(x::LLAcc,   y::AbstractArray)   y   fill(ds[1], size(y))

