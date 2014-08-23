# constants
pi<-acos(-1.0)
twopi<-2.0*pi
halfpi<-0.5*pi
degree<-pi / 180
halfSqrt2<-sqrt(2) / 2
quarterpi<-0.25 * pi
mquarterpi<--0.25 * pi
threequarterpi<-0.75 * pi
mthreequarterpi<--0.75 * pi
radian<-180/pi
sqrt2<-sqrt(2)
sqrt8<-2. * sqrt2
halfSqrt3<-sqrt(3) / 2
PeirceQuincuncialScale<-3.7081493546027438 ;# 2*K(1/2)
PeirceQuincuncialLimit<-1.8540746773013719 ;# K(1/2)


ellFaux<-function(cos_phi,sin_phi,k){
  x<-cos_phi * cos_phi
  y<-1.0 - k * k * sin_phi * sin_phi
  z<-1.0
  rf<-ellRF(x,y,z)
  return(sin_phi * rf)
}

ellRF<-function(x,y,z){
  if (x < 0.0 || y < 0.0 || z < 0.0) {
    print("Negative argument to Carlson's ellRF")
    print("ellRF negArgument")
  }
  delx<-1.0; 
  dely<-1.0; 
  delz<-1.0
  while(abs(delx) > 0.0025 || abs(dely) > 0.0025 || abs(delz) > 0.0025) {
    sx<-sqrt(x)
    sy<-sqrt(y)
    sz<-sqrt(z)
    len<-sx * (sy + sz) + sy * sz
    x<-0.25 * (x + len)
    y<-0.25 * (y + len)
    z<-0.25 * (z + len)
    mean<-(x + y + z) / 3.0
    delx<-(mean - x) / mean
    dely<-(mean - y) / mean
    delz<-(mean - z) / mean
  }
  e2<-delx * dely - delz * delz
  e3<-delx * dely * delz
  return((1.0 + (e2 / 24.0 - 0.1 - 3.0 * e3 / 44.0) * e2+ e3 / 14) / sqrt(mean))
}

toPeirceQuincuncial<-function(lambda,phi,lambda_0=20.0){
  # Convert latitude and longitude to radians relative to the
  # central meridian
  
  lambda<-lambda - lambda_0 + 180
  if (lambda < 0.0 || lambda > 360.0) {
    lambda<-lambda - 360 * floor(lambda / 360)
  }
  lambda<-(lambda - 180) * degree
  phi<-phi * degree
  
  # Compute the auxiliary quantities 'm' and 'n'. Set 'm' to match
  # the sign of 'lambda' and 'n' to be positive if |lambda| > pi/2
  
  cos_phiosqrt2<-halfSqrt2 * cos(phi)
  cos_lambda<-cos(lambda)
  sin_lambda<-sin(lambda)
  cos_a<-cos_phiosqrt2 * (sin_lambda + cos_lambda)
  cos_b<-cos_phiosqrt2 * (sin_lambda - cos_lambda)
  sin_a<-sqrt(1.0 - cos_a * cos_a)
  sin_b<-sqrt(1.0 - cos_b * cos_b)
  cos_a_cos_b<-cos_a * cos_b
  sin_a_sin_b<-sin_a * sin_b
  sin2_m<-1.0 + cos_a_cos_b - sin_a_sin_b
  sin2_n<-1.0 - cos_a_cos_b - sin_a_sin_b
  if (sin2_m < 0.0) {
    sin2_m<-0.0
  }
  sin_m<-sqrt(sin2_m)
  if (sin2_m > 1.0) {
    sin2_m<-1.0
  }
  cos_m<-sqrt(1.0 - sin2_m)
  if (sin_lambda < 0.0) {
    sin_m<--sin_m
  }
  if (sin2_n < 0.0) {
    sin2_n<-0.0
  }
  sin_n<-sqrt(sin2_n)
  if (sin2_n > 1.0) {
    sin2_n<-1.0 
  }
  cos_n<-sqrt(1.0 - sin2_n)
  if (cos_lambda > 0.0) {
    sin_n<--sin_n
  }
  
  # Compute elliptic integrals to map the disc to the square
  
  x<-ellFaux(cos_m,sin_m,halfSqrt2)
  y<-ellFaux(cos_n,sin_n,halfSqrt2)
  
  # Reflect the Southern Hemisphere outward
  
  if(phi < 0) {
    if (lambda < mthreequarterpi) {
      y<-PeirceQuincuncialScale - y
    } else if (lambda < mquarterpi) {
      x<--PeirceQuincuncialScale - x
    } else if (lambda < quarterpi) {
      y<--PeirceQuincuncialScale - y
    } else if (lambda < threequarterpi) {
      x<-PeirceQuincuncialScale - x
    } else {
      y<-PeirceQuincuncialScale - y
    }
  }
  
  # Rotate the square by 45 degrees to fit the screen better
  
  X<-(x - y) * halfSqrt2
  Y<-(x + y) * halfSqrt2
  res<-list(X,Y)
  return(res)
}


# toPeirceQuincuncial<-function(lambda,phi,lambda_0=20.0){
# lambda = longitude 
# phi = latitude
for(i in 1:360){
  pos<-toPeirceQuincuncial(i,0,0)  
  x<-pos[[1]][1]
  y<-pos[[2]][1]
  print(paste(x,";",y,sep=""))
}
