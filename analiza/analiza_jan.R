source('lib/libraries.r', encoding = 'UTF-8')

prileganje <- lm(data = dokon.stan.slo, Stevilo ~ Leto)
leta <- data.frame(Leto=seq(2017,2020,1))
napoved <- mutate(leta, Stevilo=predict(prileganje,leta))

graf.napovedi <- ggplot(dokon.stan.slo, aes(x=Leto, y=Stevilo))+ 
  geom_point() + geom_smooth(method=lm, fullrange=TRUE, color='red') + geom_point(data=napoved, inherit.aes = TRUE)+
  labs(title='Dokončana stanovanja v Sloveniji') + 
  scale_x_continuous('Leto', breaks = seq(2007, 2020, 1), limits = c(2007,2019))


