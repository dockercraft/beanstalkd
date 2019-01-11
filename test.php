<?php
include "vendor/autoload.php";

// Hopefully you're using Composer autoloading.

use Pheanstalk\Pheanstalk;

$pheanstalk = new Pheanstalk('127.0.0.1');

// ----------------------------------------
// producer (queues jobs)

$pheanstalk
  ->useTube('testtube')
  ->put("job payload goes here\n");

// ----------------------------------------
// worker (performs jobs)

$job = $pheanstalk
  ->watch('testtube')
  ->ignore('default')
  ->reserve();

echo $job->getData();

$pheanstalk->delete($job);

// ----------------------------------------
// check server availability

print_r($pheanstalk->getConnection()->isServiceListening()); // true or false