import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "barChart", "doughnutChart" ]

  connect() {
    this.chartBarGraph()
    this.chartDoughnutGraph()
  }

  chartBarGraph() {
    const canvas = document.getElementById("barChart")
    const ticketTotals = JSON.parse(canvas.dataset.totals)
    const ctx = canvas.getContext('2d');
    const myBarGraph = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: [
            `None (${ticketTotals[0]})`,
            `Low (${ticketTotals[1]})`,
            `Medium (${ticketTotals[2]})`,
            `High (${ticketTotals[3]})`
          ],
        datasets: [{
          label: '# of Tickets',
          data: ticketTotals,
          backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(54, 162, 235, 0.2)',
          'rgba(255, 206, 86, 0.2)',
          'rgba(75, 192, 192, 0.2)',
          'rgba(153, 102, 255, 0.2)',
          'rgba(255, 159, 64, 0.2)'
          ],
          borderColor: [
          'rgba(255,99,132,1)',
          'rgba(54, 162, 235, 1)',
          'rgba(255, 206, 86, 1)',
          'rgba(75, 192, 192, 1)',
          'rgba(153, 102, 255, 1)',
          'rgba(255, 159, 64, 1)'
          ],
          borderWidth: 1
        }]
      },
      options: {
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true
            }
          }]
        }
      }
    });
  }

  chartDoughnutGraph() {
    const canvas = document.getElementById("doughnutChart")
    const ticketTotals = JSON.parse(canvas.dataset.totals)
    const ctxD = canvas.getContext('2d');
    const myDoughnutGraph = new Chart(ctxD, {
      type: 'doughnut',
      data: {
        labels: [
          `New (${ticketTotals[0]})`,
          `Open (${ticketTotals[1]})`,
          `In Progress (${ticketTotals[2]})`,
          `Resolved (${ticketTotals[3]})`,
          `More Info Needed (${ticketTotals[4]})`
        ],
        datasets: [{
          data: ticketTotals,
          backgroundColor: ["#F7464A", "#46BFBD", "#FDB45C", "#949FB1", "#4D5360"],
          hoverBackgroundColor: ["#FF5A5E", "#5AD3D1", "#FFC870", "#A8B3C5", "#616774"]
        }]
      },
      options: {
        responsive: true
      }
    });
  }
}
