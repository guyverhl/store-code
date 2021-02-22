library(dplyr)
library(ggplot2)
library(survival)
library(survminer)
library(survRM2)

colon = read.delim('/Users/guyverchan/Documents/HKU/STAT3622/quiz1/colon.txt', header = TRUE, sep = ",")

# a
fit = survfit(Surv(PFT, status_PF) ~ group, data = colon)
ggsurvplot(fit, data = colon, pval = TRUE, risk.table = TRUE,
           conf.int = T, surv.median.line = "hv",
           xlab= "Days", ylab = "Survival probability",
           legend.labs =c("0", "1"), risk.table.height = 0.3,
           ggtheme = theme_bw())
survdiff(Surv(PFT, status_PF) ~ group, data = colon, rho=0)

# b
fit_b = survfit(Surv(OT, status_O) ~ group, data = colon)
ggsurvplot(fit_b, data = colon, pval = TRUE, risk.table = TRUE,
           conf.int = T, surv.median.line = "hv",
           xlab= "Days", ylab = "Survival probability",
           legend.labs =c("0", "1"), risk.table.height = 0.3,
           ggtheme = theme_bw())
survdiff(Surv(OT, status_O) ~ group, data = colon, rho=0)

# c
RMST_P = c()
PFT_max_min = summarize(group_by(colon, group=group), 
                        PFT.max=max(PFT),
                        PFT.min=min(PFT))

maxmin_P = min(PFT_max_min$PFT.max, na.rm=TRUE)
minmax_P = max(PFT_max_min$PFT.min, na.rm=TRUE)
P_interval = seq(minmax_P, maxmin_P, length.out=22)
for (i in P_interval) {
  RMST_P = c(RMST_P, rmst2(colon$PFT, colon$status_PF, colon$group, tau = i)$unadjusted.result[1])
}
RMST_SCATTERED_P = cbind(P_interval, RMST_P)

# d
RMST_O = c()
OT_max_min = summarize(group_by(colon, group=group), 
                       OT.max=max(OT),
                       OT.min=min(OT))

maxmin_O = min(OT_max_min$OT.max, na.rm=TRUE)
minmax_O = max(OT_max_min$OT.min, na.rm=TRUE)
O_interval = seq(minmax_O, maxmin_O, length.out=22)
for (i in O_interval) {
  RMST_O = c(RMST_O, rmst2(colon$OT, colon$status_O, colon$group, tau = i)$unadjusted.result[1])
}
RMST_SCATTERED_O = cbind(O_interval, RMST_O)

# e
RMST_SCATTERED_P = data.frame(RMST_SCATTERED_P)
RMST_SCATTERED_O = data.frame(RMST_SCATTERED_O)

ggplot(RMST_SCATTERED_P, aes(x = P_interval, y = RMST_P)) +
  geom_point() +
  xlab("Days") + 
  theme_bw() + 
  ggtitle("Scatter plot of RMST_P vs Days")

ggplot(RMST_SCATTERED_O, aes(x = O_interval, y = RMST_O)) +
  geom_point() +
  xlab("Days") + 
  theme_bw() + 
  ggtitle("Scatter plot of RMST_O vs Days")

# f
cor.test(x=RMST_SCATTERED_P$RMST_P, y=RMST_SCATTERED_O$RMST_O, method = 'spearman')
cor.test(x=RMST_SCATTERED_P$RMST_P, y=RMST_SCATTERED_O$RMST_O, method = 'kendall')


# ---------------------
gastadv = read.delim('/Users/guyverchan/Documents/HKU/STAT3622/quiz1/gastadv.txt', header = TRUE, sep = ",")

fit = survfit(Surv(PFT, status_PF) ~ group, data = gastadv)
ggsurvplot(fit, data = gastadv, pval = TRUE, risk.table = TRUE,
           conf.int = T, surv.median.line = "hv",
           xlab= "Days", ylab = "Survival probability",
           legend.labs =c("0", "1"), risk.table.height = 0.3,
           ggtheme = theme_bw())
survdiff(Surv(PFT, status_PF) ~ group, data = gastadv, rho=0)

fit_b = survfit(Surv(OT, status_O) ~ group, data = gastadv)
ggsurvplot(fit_b, data = gastadv, pval = TRUE, risk.table = TRUE,
           conf.int = T, surv.median.line = "hv",
           xlab= "Days", ylab = "Survival probability",
           legend.labs =c("0", "1"), risk.table.height = 0.3,
           ggtheme = theme_bw())
survdiff(Surv(OT, status_O) ~ group, data = gastadv, rho=0)

RMST_P = c()
PFT_max_min = summarize(group_by(gastadv, group=group), 
                        PFT.max=max(PFT),
                        PFT.min=min(PFT))

maxmin_P = min(PFT_max_min$PFT.max, na.rm=TRUE)
minmax_P = max(PFT_max_min$PFT.min, na.rm=TRUE)
P_interval = seq(minmax_P, maxmin_P, length.out=22)
for (i in P_interval) {
  RMST_P = c(RMST_P, rmst2(gastadv$PFT, gastadv$status_PF, gastadv$group, tau = i)$unadjusted.result[1])
}
RMST_SCATTERED_P = cbind(P_interval, RMST_P)


RMST_O = c()
OT_max_min = summarize(group_by(gastadv, group=group), 
                       OT.max=max(OT),
                       OT.min=min(OT))

maxmin_O = min(OT_max_min$OT.max, na.rm=TRUE)
minmax_O = max(OT_max_min$OT.min, na.rm=TRUE)
O_interval = seq(minmax_O, maxmin_O, length.out=22)
for (i in O_interval) {
  RMST_O = c(RMST_O, rmst2(gastadv$OT, gastadv$status_O, gastadv$group, tau = i)$unadjusted.result[1])
}
RMST_SCATTERED_O = cbind(O_interval, RMST_O)

# e
RMST_SCATTERED_P = data.frame(RMST_SCATTERED_P)
RMST_SCATTERED_O = data.frame(RMST_SCATTERED_O)

ggplot(RMST_SCATTERED_P, aes(x = P_interval, y = RMST_P)) +
  geom_point() +
  xlab("Days") + 
  theme_bw() + 
  ggtitle("Scatter plot of RMST_P vs Days")

ggplot(RMST_SCATTERED_O, aes(x = O_interval, y = RMST_O)) +
  geom_point() +
  xlab("Days") + 
  theme_bw() + 
  ggtitle("Scatter plot of RMST_P vs Days")

# f
cor.test(x=RMST_SCATTERED_P$RMST_P, y=RMST_SCATTERED_O$RMST_O, method = 'spearman')
cor.test(x=RMST_SCATTERED_P$RMST_P, y=RMST_SCATTERED_O$RMST_O, method = 'kendall')

# -------------------------
ovarian = read.delim('/Users/guyverchan/Documents/HKU/STAT3622/quiz1/ovarian.txt', header = TRUE, sep = ",")

fit = survfit(Surv(PFT, status_PF) ~ group, data = ovarian)
ggsurvplot(fit, data = ovarian, pval = TRUE, risk.table = TRUE,
           conf.int = T, surv.median.line = "hv",
           xlab= "Days", ylab = "Survival probability",
           legend.labs =c("0", "1"), risk.table.height = 0.3,
           ggtheme = theme_bw())
survdiff(Surv(PFT, status_PF) ~ group, data = ovarian, rho=0)

fit_b = survfit(Surv(OT, status_O) ~ group, data = ovarian)
ggsurvplot(fit_b, data = ovarian, pval = TRUE, risk.table = TRUE,
           conf.int = T, surv.median.line = "hv",
           xlab= "Days", ylab = "Survival probability",
           legend.labs =c("0", "1"), risk.table.height = 0.3,
           ggtheme = theme_bw())
survdiff(Surv(OT, status_O) ~ group, data = ovarian, rho=0)

RMST_P = c()
PFT_max_min = summarize(group_by(ovarian, group=group), 
                        PFT.max=max(PFT),
                        PFT.min=min(PFT))

maxmin_P = min(PFT_max_min$PFT.max, na.rm=TRUE)
minmax_P = max(PFT_max_min$PFT.min, na.rm=TRUE)
P_interval = seq(minmax_P, maxmin_P, length.out=22)
for (i in P_interval) {
  RMST_P = c(RMST_P, rmst2(ovarian$PFT, ovarian$status_PF, ovarian$group, tau = i)$unadjusted.result[1])
}
RMST_SCATTERED_P = cbind(P_interval, RMST_P)


RMST_O = c()
OT_max_min = summarize(group_by(ovarian, group=group), 
                       OT.max=max(OT),
                       OT.min=min(OT))

maxmin_O = min(OT_max_min$OT.max, na.rm=TRUE)
minmax_O = max(OT_max_min$OT.min, na.rm=TRUE)
O_interval = seq(minmax_O, maxmin_O, length.out=22)
for (i in O_interval) {
  RMST_O = c(RMST_O, rmst2(ovarian$OT, ovarian$status_O, ovarian$group, tau = i)$unadjusted.result[1])
}
RMST_SCATTERED_O = cbind(O_interval, RMST_O)

# e
RMST_SCATTERED_P = data.frame(RMST_SCATTERED_P)
RMST_SCATTERED_O = data.frame(RMST_SCATTERED_O)

ggplot(RMST_SCATTERED_P, aes(x = P_interval, y = RMST_P)) +
  geom_point() +
  xlab("Times") + 
  theme_bw() + 
  ggtitle("Scatter plot of RMST_P vs Times")

ggplot(RMST_SCATTERED_O, aes(x = O_interval, y = RMST_O)) +
  geom_point() +
  xlab("Times") + 
  theme_bw() + 
  ggtitle("Scatter plot of RMST_P vs Times")

# f
cor.test(x=RMST_SCATTERED_P$RMST_P, y=RMST_SCATTERED_O$RMST_O, method = 'spearman')
cor.test(x=RMST_SCATTERED_P$RMST_P, y=RMST_SCATTERED_O$RMST_O, method = 'kendall')

