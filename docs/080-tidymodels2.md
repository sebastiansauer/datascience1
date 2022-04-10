# tidymodels 2



## Resampling


Vergleichen Sie die drei Fälle, die sich in der Nutzung von Train- und Test-Sample unterscheiden:

1. Wir fitten ein Klassifikationsmodell in einer Stichprobe, sagen die Y-Werte dieser Stichprobe "vorher". Wir finden eine Gesamtgenauigkeit von 80%.
2. Wir fitten ein Klassifikationsmodell in einem Teil der ursprünglichen Stichprobe (Train-Sample) und sagen Y-die Werte im verbleibenden Teil der ursprünglichen Stichprobe vorher (Test-Sample). Wir finden eine Gesamtgenauigkeit von 70%.
3. Wir wiederholen Fall 2 noch drei Mal mit jeweils anderer Zuweisung der Fälle zum Train- bzw. zum Test-Sample. Wir finden insgesamt folgende Werte an Gesamtgenauigkeit: 70%, 70%, 65%, 75%.


Welchen der drei Fälle finden Sie am sinnvollsten? Warum?



## Illustration des Resampling

Abb. \@ref(fig:resampling) illustriert die zufällige Aufteilung von $n=10$ Fällen der Originalstrichprobe auf eine Train- bzw. Test-Stichpobe. 
In diesem Fall wurden 70% der (10) Fälle der Train-Stichprobe zugewiesen (der Rest der Test-Stichprobe);
ein willkürlicher, aber nicht unüblicher Anteil.
Diese Aufteilung wurde drei Mal vorgenommen,
es resultieren drei "Resampling-Stichproben".


<div class="figure" style="text-align: center">
<img src="080-tidymodels2_files/figure-html/resampling-1.png" alt="Resampling: Eine Stichprobe wird mehrfach (hier 3 Mal) zu 70% in ein Train- und zu 30% in die Test-Stichprobe aufgeteilt" width="100%" />
<p class="caption">(\#fig:resampling)Resampling: Eine Stichprobe wird mehrfach (hier 3 Mal) zu 70% in ein Train- und zu 30% in die Test-Stichprobe aufgeteilt</p>
</div>


Es gibt eine Reihe vergleichbarer Illustrationen in anderen Büchern:

- [Timbers, Campbell & Lee, 2022, Kap. 6](https://datasciencebook.ca/img/cv.png)
- [Silge & Kuhn, 2022, Abb. 10.1](https://datasciencebook.ca/img/cv.png)
- [Silge & Kuhn, 2022, Abb. 10.2](https://www.tmwr.org/premade/three-CV.svg)
- [Silge & Kuhn, 2022, Abb. 10.3](https://www.tmwr.org/premade/three-CV-iter.svg)
