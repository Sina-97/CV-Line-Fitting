using Pkg
using Noise 
# Pkg.add("MAT")
using Images
using Plots
using ImageFiltering
using Random
using Statistics
using ImageEdgeDetection
using ImageEdgeDetection: Percentile
using LinearAlgebra
using MAT

data=matread(joinpath(@__DIR__, "xy.mat"))
k=512
theta=[1;1;1]
points=data["xy"]'
datapoint=data.vals
point=[points ones(k,1)]
iterations=2000
theta=zeros(iterations+1,3)
theta[1,:]=[1;1;-6]
for itr=1:iterations
    n1=10^-11
    n2=10^-11
    n3=10^-11
    dthetaa=0
    dthetab=0
    dthetac=0
    f=0
for i=1:k
     dthetaa=dthetaa+(2 .*(point[k,1]))*(theta[itr,:]'*point[k,:])
     dthetab=dthetab+(2 .*(point[k,2]))*(theta[itr,:]'*point[k,:])
     dthetac=dthetac+(2)*(theta[itr,:]'*point[k,:])
end
global theta[itr+1,1]=theta[itr,1]-n1*dthetaa
global theta[itr+1,2]=theta[itr,2]-n2*dthetab
global theta[itr+1,3]=theta[itr,3]-n3*dthetac
end

p1=scatter(point[:,1],point[:,2],ms=1.5, ma=0.6)
x=1:k
y=zeros(k,1)
for i=1:k
y[i,1]=-(theta[end,1]*i+theta[end,3])/theta[end,2]
end
p1=plot!(x,y,ma=0.5 , ms=1)
display(p1)

# n=10e-11
