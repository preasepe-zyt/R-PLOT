library(Rtools)
library(foreign)
library (lavaan)
library(EFAutilities)

dat = read.spss("DATASET.sav", to.data.frame =T)#tolti sogg con troppi missing (listwise) 
dat
names(dat)
str(dat)

#APPLY FILTER FOR MISSINGS 
data<-[dat[dat$FILTER=="Selected",]#TO REMOVE ALL MISSINGS IN LF AND TYPE OF MEDIA USE
str(data)#WORKING WITH 764 CASES

#descriptives
summary(p)
names(p)
p$独生子女 <- as.factor(p$独生子女)
data$BEGIN_DATE<-as.factor(data$BEGIN_DATE)
data$income_stab_cat2<-as.factor(data$income_stab_cat2)
data$NATIONALITY_2CAT<-as.factor(data$NATIONALITY_2CAT)
(p$独生子女)
levels(data$NATIONALITY_2CAT)

#preliminary models
#Model for a mean latent intercept and constrained residual variances.

latent_1 <- "
# intercept
i =~ 1*m_fu_m1 + 1*m_fu_m2 + 1*m_fu_m3 + 1*m_fu_m4+1*m_fu_m5
i~~0*i
# residual variances
m_fu_m1~~r*m_fu_m1
m_fu_m2~~r*m_fu_m2
m_fu_m3~~r*m_fu_m3
m_fu_m4~~r*m_fu_m4
m_fu_m5~~r*m_fu_m5
"

model_latent1 <- growth(latent_1, data=data, missing="FIML", estimator="MLR")
summary(model_latent1, fit.measures=T, standardized=T)

#Model for a mean latent intercept that is
#allowed to vary, and constrained residual variances.
latent_2 <- '
# intercept
i =~ 1*m_fu_m1 + 1*m_fu_m2 + 1*m_fu_m3 + 1*m_fu_m4+1*m_fu_m5
# residual variances
m_fu_m1~~r*m_fu_m1
m_fu_m2~~r*m_fu_m2
m_fu_m3~~r*m_fu_m3
m_fu_m4~~r*m_fu_m4
m_fu_m5~~r*m_fu_m5

'

model_latent2 <- growth(latent_2, data=data, missing="FIML", estimator="MLR")
summary(model_latent2, fit.measures=T, standardized=T)


#Model with a mean latent intercept that is
#allowed to vary, mean latent slope, and
#constrained residual variances.

latent_3 <- '
# intercept
i =~ 1*m_fu_m1 + 1*m_fu_m2 + 1*m_fu_m3 + 1*m_fu_m4+1*m_fu_m5
# slope
s =~ 0*m_fu_m1 + 1*m_fu_m2 + 2*m_fu_m3 + 3*m_fu_m4+4*m_fu_m5
s~~0*i
# residual variances
m_fu_m1~~r*m_fu_m1
m_fu_m2~~r*m_fu_m2
m_fu_m3~~r*m_fu_m3
m_fu_m4~~r*m_fu_m4
m_fu_m5~~r*m_fu_m5
'

model_latent3 <- growth(latent_3, data=data, missing="FIML", estimator="MLR")
summary(model_latent3, fit.measures=T, standardized=T)

# Model for a mean latent intercept that is
#allowed to vary, mean latent slope that is
#allowed to vary, and constrained residual
#variances.

latent_4 <- '
# intercept
i =~ 1*m_fu_m1 + 1*m_fu_m2 + 1*m_fu_m3 + 1*m_fu_m4+1*m_fu_m5

# slope
s =~ 0*m_fu_m1 + 1*m_fu_m2 + 2*m_fu_m3 + 3*m_fu_m4+4*m_fu_m5
# residual variances
m_fu_m1~~r*m_fu_m1
m_fu_m2~~r*m_fu_m2
m_fu_m3~~r*m_fu_m3
m_fu_m4~~r*m_fu_m4
m_fu_m5~~r*m_fu_m5
'
model_latent4 <- growth(latent_4, data=data, missing="FIML", estimator="MLR")
summary(model_latent4, fit.measures=T, standardized=T)



#Unconstrained model

latent_5 <- '
# intercept
i =~ 1*m_fu_m1 + 1*m_fu_m2 + 1*m_fu_m3 + 1*m_fu_m4+1*m_fu_m5

# slope
s =~ 0*m_fu_m1 + 1*m_fu_m2 + 2*m_fu_m3 + 3*m_fu_m4+4*m_fu_m5'

model_latent5 <- growth(latent_5, data=data, missing="FIML", estimator="MLR")
summary(model_latent5, fit.measures=T, standardized=T)


#Unconstrained model with
#curvilinear growth

latent_quadratic <- '
# intercept
i =~ 1*m_fu_m1 + 1*m_fu_m2 + 1*m_fu_m3 + 1*m_fu_m4+1*m_fu_m5

# slope
s =~ 0*m_fu_m1 + 1*m_fu_m2 + 2*m_fu_m3 + 3*m_fu_m4+4*m_fu_m5
s1 =~ 0*m_fu_m1 + 1*m_fu_m2 + 4*m_fu_m3 + 9*m_fu_m4+16*m_fu_m5
'
model_quadratic <- growth(latent_quadratic, data=data, missing="FIML", estimator="MLR")
summary(model_quadratic, fit.measures=T, standardized=T)


#model comaprison
anova(model_latent1, model_latent2, model_latent3, model_latent4, model_latent5, model_quadratic)

####FINAL MODEL #### 
#Unconstrained model with
#curvilinear growth
#plus covariates

latent_quadratic_cov<-"
# intercept
i =~ 1*m_fu_m1 + 1*m_fu_m2 + 1*m_fu_m3 + 1*m_fu_m4+1*m_fu_m5

# slope
s =~ 0*m_fu_m1 + 1*m_fu_m2 + 2*m_fu_m3 + 3*m_fu_m4+4*m_fu_m5
s1 =~ 0*m_fu_m1 + 1*m_fu_m2 + 4*m_fu_m3 + 9*m_fu_m4+16*m_fu_m5

#regression- add covariates: 
#perceived financial situation, begin date, gender, age group, social- and process- oriented digital media use

i ~ income_stab_cat2+BEGIN_DATE2+GENDER_F+cit_group+NATIONALITY_2CAT+MEDIA_USE_SOCIAL+MEDIA_USE_PROCESSING
s ~ income_stab_cat2+BEGIN_DATE2+GENDER_F+cit_group+NATIONALITY_2CAT+MEDIA_USE_SOCIAL+MEDIA_USE_PROCESSING
s1 ~ income_stab_cat2+BEGIN_DATE2+GENDER_F+cit_group+NATIONALITY_2CAT+MEDIA_USE_SOCIAL+MEDIA_USE_PROCESSING"

modelfit_latent_quadratic_cov<- growth(latent_quadratic_cov, data=data, missing="FIML",estimator ="MLR")
summary(modelfit_latent_quadratic_cov, fit.measures=T,standardized=T)#with income AND MLR ESTIMATOR


