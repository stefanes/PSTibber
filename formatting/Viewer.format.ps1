Write-FormatView -TypeName Viewer -Property 'User Id', User -VirtualProperty @{
    'User Id' = {
        $($_.userId)
    }
    User      = {
        "$($_.name) <$($_.login)>"
    }
}
