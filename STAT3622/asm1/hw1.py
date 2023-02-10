import pandas as pd
import numpy as np
from datetime import datetime 
import matplotlib.pyplot as plt
import matplotlib.dates as mdates

accept = pd.read_csv('LC_Accept.csv', sep=',')
decline = pd.read_csv('LC_Decline.csv', sep=',')
df = pd.concat([accept, decline])

# Q4a
def q4a():
    date_list = sorted(list(set(df['Date'].tolist())))
    no_of_accept = [len(accept.loc[accept['Date'] == date_list[i]]) for i in range(0, len(date_list))]
    total_application = [len(df.loc[df['Date'] == date_list[i]]) for i in range(0, len(date_list))]
    accept_rate = [no_of_accept[i]/total_application[i] * 100 for i in range(0, len(no_of_accept))]

    date_list = [datetime.strptime(str(s), '%Y%m') for s in date_list] 
    date_list = [np.datetime64(i) for i in date_list]

    fig, ax = plt.subplots()
    ax.plot(date_list,accept_rate, color = 'steelblue', marker='.')
    
    years = mdates.YearLocator()
    months = mdates.MonthLocator()
    years_fmt = mdates.DateFormatter('%Y')
    ax.xaxis.set_major_locator(years)
    ax.xaxis.set_major_formatter(years_fmt)
    ax.xaxis.set_minor_locator(months)

    datemin = np.datetime64(date_list[0], 'Y')
    datemax = np.datetime64(date_list[-1], 'Y') + np.timedelta64(1, 'Y')
    ax.set_xlim(datemin, datemax)
    ax.format_xdata = mdates.DateFormatter('%Y-%m-%d')
    plt.title('Acceptance rates of loan applications')
    plt.xlabel('Year')
    plt.ylabel('% of acceptance rates')
    plt.show()

# Q4b
def q4b():
    purpose_list = sorted(list(set(df['Purpose'].tolist())))
    accpet_loan_purpose = [len(accept.loc[accept['Purpose'] == purpose_list[i]]) for i in range(0, len(purpose_list))]
    decline_loan_purpose = [len(decline.loc[decline['Purpose'] == purpose_list[i]]) for i in range(0, len(purpose_list))]

    x = np.arange(len(purpose_list))
    width = 0.35
    fig, ax = plt.subplots()
    accept_rects = ax.barh(x - width/2, accpet_loan_purpose, width, label='Accept Loan Purpose')
    decline_rects = ax.barh(x + width/2, decline_loan_purpose, width, label='Decline Loan Purpose')

    ax.set_xlabel('Number of purposes')
    ax.set_title('Loan purposes by the status of acceptance and declination')
    ax.set_yticks(x)
    ax.set_yticklabels(purpose_list)
    ax.legend()
    fig.tight_layout()
    plt.show()

# Q4c
def q4c():
    fig, (ax1, ax2, ax3, ax4) = plt.subplots(nrows=1, ncols=4, figsize=(15, 7))
    labels = ["Accept", "Decline"]
    bplot1 = ax1.boxplot([accept['Amount_Requested'], decline['Amount_Requested']],
                        vert=True, patch_artist=True, labels=labels, showfliers=False)
    ax1.set_title('Amount Requested')

    bplot2 = ax2.boxplot([accept['Risk_Score'], decline['Risk_Score']],
                        vert=True, patch_artist=True, labels=labels, showfliers=False)
    ax2.set_title('Risk Score')

    bplot3 = ax3.boxplot([accept['Debt_Income_Ratio'], decline['Debt_Income_Ratio']],
                        vert=True, patch_artist=True, labels=labels, showfliers=False)
    ax3.set_title('Debt Income Ratio')

    bplot4 = ax4.boxplot([accept['Employment_Length'], decline['Employment_Length']],
                        vert=True, patch_artist=True, labels=labels, showfliers=False)
    ax4.set_title('Employment Length')

    colors = ['lightblue', 'pink']
    for bplot in (bplot1, bplot2, bplot3, bplot4):
        for patch, color in zip(bplot['boxes'], colors):
            patch.set_facecolor(color)

    fig.subplots_adjust(hspace=0.4)
    plt.show()

q4a()
q4b()
q4c()
