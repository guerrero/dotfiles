<?php

require('workflows.php');
$w = new Workflows();

exec( 'mdfind -name readitLater3.sqlite', $db );
$db = $db[0];

$words = $argv[1];
$words = explode( " ", $words );

$i = 0;
while( $word = $words[$i] ):
	$title[$i] = 'url like \"%'.$word.'%\"';
	$descr[$i] = 'title like \"%'.$word.'%\"';
	$url[$i] = 'excerpt like \"%'.$word.'%\"';
	$i++;
endwhile;
$title = implode( " AND ", $title );
$descr = implode( " AND ", $descr );
$url = implode( " AND ", $url );

exec( 'sqlite3 -separator "	" -list "'.$db.'" "select title, url from items where ('.$title.') or ('.$descr.') or ('.$url.')"', $results );

if ( count( $results ) == 0 ):
	$w->result( 'pocket.result', 'na', 'No results found', 'No search results found matching your query', 'icon.png', 'no' );
else:
	foreach( $results as $result ):
		$result = explode( "	", $result );
		$title = $result[0];
		$url = $result[1];
		if ( $title == "" ):
			$title = $url;
		endif;
		$w->result( 'pocket.result', $url, $title, $url, 'icon.png' );
	endforeach;
endif;

echo $w->toxml();