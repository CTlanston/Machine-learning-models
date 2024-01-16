# hw2 copy
# Read in the data

# Note: Change Filename once the data is finalized
FileName <- "C:\\Users\\ctlan\\OneDrive\\desktop\\AI & machine learning\\assignment\\HW2\\SelfieImageDataFinal.csv"
Labs <- scan(file=FileName,what="xx",nlines=1,sep="|")

DataAsChars <- matrix(scan(file=FileName,what="xx",sep="|",skip=1),byrow=T,ncol=length(Labs))

colnames(DataAsChars) <- Labs
dim(DataAsChars)
# size in memory in MBs
as.double(object.size(DataAsChars)/1024/1024)

ImgData <- matrix(as.integer(DataAsChars[,-1]),nrow=nrow(DataAsChars))
colnames(ImgData) <- Labs[-1]
rownames(ImgData) <- DataAsChars[,1]
# size in memory in MBs
as.double(object.size(ImgData)/1024/1024)



#Question 2 Average Face
mean_face <- colMeans(ImgData, na.rm = TRUE)
length(mean_face)
image_dim <- sqrt(length(mean_face))
mean_face_matrix <- matrix(mean_face, nrow=image_dim, ncol=image_dim, byrow=TRUE)
mean_face_matrix <- apply(mean_face_matrix, 2, rev) # Flip the rows to display the image correctly
par(pty="s",mfrow=c(1,1)) # Plotting
image(z=t(mean_face_matrix), col=grey.colors(255), useRaster=T, main="Average Face")


#Question 5 eigenvalue plot
Col_mean <- apply(ImgData, 2, mean)
# Col_mean2 <- colMeans(ImgData, na.rm = TRUE)
Xc <- sweep(ImgData, MARGIN = 2, STATS = Col_mean, FUN = "-")

smallMatrix <- Xc %*%  t(Xc)
eigenSmallMatrix <- eigen(smallMatrix)

big_eigenValues <- eigenSmallMatrix$values / (nrow(ImgData) - 1)

big_eigenVectors <- t(Xc) %*% eigenSmallMatrix$vectors
big_eigenVectors <- apply(big_eigenVectors, 2, function(x) x / sqrt(sum(x^2)))
SDecomp <- list(values = big_eigenValues, vectors = big_eigenVectors)
par(mfrow=c(1,2))  # Plot eigenvalues to get an idea of the dimension needed.
plot(SDecomp$values)
title("Scree Plot")
# plot((SDecomp$values)^(1/3))
# title("Cube Root Eigenvalues")






#question 6 the largetst eigenvalue 
largest_eigenvalue <- SDecomp$values[1]
print(largest_eigenvalue)


#question 7 how many covered in 85% total variance 
sum(cumsum(SDecomp$values)/sum(SDecomp$values) < 0.85) + 1 #  need to add 1, since it means above
sum(cumsum(big_eigenValues)/sum(big_eigenValues) < 0.85) + 1 


#question 8 reconstruct and compare with older one
index <- which(DataAsChars[, 1] == "tche368")
print(index)

NVecs <- 20
PCompTrain150d <- ImgData%*%big_eigenVectors[,1:NVecs]
dim(PCompTrain150d)
ReconTrain150d <- PCompTrain150d%*%t(big_eigenVectors[,1:NVecs])
dim(ReconTrain150d)

par(mfrow=c(1,2),pty="s")
# i <- sample(nrow(ImgData),size=1)
# cat("Image",i,"\n")
# range(ImgData[i,-1])
ImageData1 <- matrix(ImgData[11,-1],byrow=T,ncol=451)
ImageData1 <- t(apply(ImageData1,2,rev))
image(z=ImageData1,col = grey.colors(255),useRaster=T)
title("My face original")

ImageData2 <- matrix(ReconTrain150d[11,],byrow=T,ncol=451)
ImageData2 <- t(apply(ImageData2,2,rev))
image(z=ImageData2,col = grey.colors(255),useRaster=T)
title("My face 20D")




#question10 plot the 8th eigenvalue plots
vec <- SDecomp$vector[,8]
vec <- (vec-min(vec))/(max(vec)-min(vec))
vec <- vec*255
range(vec)
vecImage <- matrix(vec,byrow=T,ncol=sqrt(ncol(t(vec))))
vecImage <- t(apply(vecImage,2,rev))
image(z=vecImage,col = grey.colors(255),useRaster=T)
title("Eigenface 8")

out <- tapply(PCompTrain150d[,8],INDEX=ImgData[,1],FUN=function(x) {x} )
boxplot(out)
title("The 8th Principle Component by Digit")





#question11
# Create a new device for plotting
dev.new()

# Set the layout to 4x5
par(mfrow=c(4,5))

# Plot the eigenface images
for (i in 1:20) {
  # Extract the i-th eigenvector
  vec <- SDecomp$vectors[, i]
  
  # Normalize the eigenvector to have values between 0 and 255
  vec_normalized <- (vec - min(vec)) / (max(vec) - min(vec))
  vec_normalized <- vec_normalized * 255
  
  # Reshape the vector into a 451x451 matrix
  vec_image <- matrix(vec_normalized, nrow=451, ncol=451, byrow=TRUE)
  
  # Transpose and flip the image
  vec_image <- t(apply(vec_image, 2, rev))
  
  # Plot the eigenface image
  image(1:451, 1:451, vec_image, col=gray.colors(256), axes=FALSE, xlab='', ylab='', main=paste("Eigenface", i))
  Sys.sleep(10)
  }

# Close the device
dev.off()










#Question12 compare the eigen value and vector of original data and the center data 
X <- ImgData
smallMatrix2 <- X %*%  t(X)
eigenSmallMatrix2 <- eigen(smallMatrix2)
big_eigenValues2 <- eigenSmallMatrix2$values / (nrow(ImgData) - 1)
big_eigenVectors2 <- t(X) %*% eigenSmallMatrix2$vectors


eigenVectors2 <- apply(big_eigenVectors2, 2, function(x) x / sqrt(sum(x^2)))
SDecomp_not_cen <- list(values = big_eigenValues2, vectors = big_eigenVectors2)
par(mfrow=c(1,2))  # Plot eigenvalues to get an idea of the dimension needed.
plot(SDecomp$values)
title("Xc Eigenvalues")
plot(SDecomp_not_cen$values)
title("Original Eigenvalues")





#question14 compare 20th principle componenets with
par(mfrow=c(1,2),pty="s")

NVecs <- 20
PCompTrain150d <- ImgData%*%big_eigenVectors[,1:NVecs]
ReconTrain150d <- PCompTrain150d%*%t(big_eigenVectors[,1:NVecs])

ImageData1 <- matrix(ReconTrain150d[11,],byrow=T,ncol=451)
ImageData1 <- t(apply(ImageData1,2,rev))
image(z=ImageData1,col = grey.colors(255),useRaster=T)
title("My FaceID 20 centered")

#not centered 

PCompTrain_no_cen <- ImgData%*%eigenVectors2[,1:NVecs]
ReconTrain_no_cen <- PCompTrain150d%*%t(eigenVectors2[,1:NVecs])
ImageData2 <- matrix(ReconTrain150d[11,],byrow=T,ncol=451)
ImageData2 <- t(apply(ImageData2,2,rev))
image(z=ImageData2,col = grey.colors(255),useRaster=T)
title("My FaceID 20 not centered")
