Write-FormatView -TypeName Price -Property From, Cost -VirtualProperty @{
    From = {
        $($_.startsAt)
    }
    Cost = {
        $value = ($_.total).ToString("0.00")
        $out = "$value $($_.currency) ($(($_.level).ToLower() -replace '_', ' '))"
        $out # output object
    }
} -ColorRow {
    switch ($_.level) {
        # https://developer.tibber.com/docs/reference#pricelevel
        VERY_CHEAP {
            '#13A10E' # dark green
        }
        CHEAP {
            '#16C60C' # bright green
        }
        NORMAL {
            '#FFFFFF' # white
        }
        EXPENSIVE {
            '#F9F1A5' # bright yellow
        }
        VERY_EXPENSIVE {
            '#E74856' # bright red
        }
    }
}
